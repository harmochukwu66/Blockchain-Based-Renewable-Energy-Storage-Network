;; Network Coordination Contract
;; Manages distributed storage network operations

(define-constant ERR-NOT-AUTHORIZED (err u200))
(define-constant ERR-INVALID-REQUEST (err u201))
(define-constant ERR-INSUFFICIENT-CAPACITY (err u202))

(define-data-var network-operator principal tx-sender)

(define-map energy-requests
  { request-id: uint }
  {
    requester: principal,
    energy-amount: uint,
    max-price: uint,
    fulfilled: bool,
    timestamp: uint
  }
)

(define-map network-status
  { status-key: (string-ascii 20) }
  { value: uint }
)

(define-data-var request-counter uint u0)

;; Initialize network status
(map-set network-status { status-key: "total-capacity" } { value: u0 })
(map-set network-status { status-key: "available-energy" } { value: u0 })
(map-set network-status { status-key: "active-facilities" } { value: u0 })

(define-public (submit-energy-request (energy-amount uint) (max-price uint))
  (let ((request-id (+ (var-get request-counter) u1)))
    (asserts! (> energy-amount u0) ERR-INVALID-REQUEST)
    (asserts! (> max-price u0) ERR-INVALID-REQUEST)

    (map-set energy-requests
      { request-id: request-id }
      {
        requester: tx-sender,
        energy-amount: energy-amount,
        max-price: max-price,
        fulfilled: false,
        timestamp: block-height
      }
    )
    (var-set request-counter request-id)
    (ok request-id)
  )
)

(define-public (fulfill-energy-request (request-id uint))
  (let ((request (unwrap! (map-get? energy-requests { request-id: request-id }) ERR-INVALID-REQUEST)))
    (asserts! (is-eq tx-sender (var-get network-operator)) ERR-NOT-AUTHORIZED)
    (asserts! (not (get fulfilled request)) ERR-INVALID-REQUEST)

    (map-set energy-requests
      { request-id: request-id }
      (merge request { fulfilled: true })
    )
    (ok true)
  )
)

(define-public (update-network-capacity (total-capacity uint) (available-energy uint) (active-facilities uint))
  (begin
    (asserts! (is-eq tx-sender (var-get network-operator)) ERR-NOT-AUTHORIZED)

    (map-set network-status { status-key: "total-capacity" } { value: total-capacity })
    (map-set network-status { status-key: "available-energy" } { value: available-energy })
    (map-set network-status { status-key: "active-facilities" } { value: active-facilities })
    (ok true)
  )
)

(define-read-only (get-energy-request (request-id uint))
  (map-get? energy-requests { request-id: request-id })
)

(define-read-only (get-network-status (status-key (string-ascii 20)))
  (map-get? network-status { status-key: status-key })
)

(define-read-only (get-request-count)
  (var-get request-counter)
)
