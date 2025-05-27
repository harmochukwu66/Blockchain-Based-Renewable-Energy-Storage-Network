;; Grid Services Contract
;; Provides system-wide storage services

(define-constant ERR-NOT-AUTHORIZED (err u300))
(define-constant ERR-SERVICE-NOT-FOUND (err u301))
(define-constant ERR-INVALID-PARAMETERS (err u302))

(define-data-var grid-operator principal tx-sender)

(define-map grid-services
  { service-id: uint }
  {
    service-type: (string-ascii 50),
    provider: principal,
    capacity: uint,
    price-per-kwh: uint,
    active: bool,
    created-at: uint
  }
)

(define-map service-usage
  { usage-id: uint }
  {
    service-id: uint,
    consumer: principal,
    energy-used: uint,
    cost: uint,
    timestamp: uint
  }
)

(define-data-var service-counter uint u0)
(define-data-var usage-counter uint u0)

(define-public (register-grid-service (service-type (string-ascii 50)) (capacity uint) (price-per-kwh uint))
  (let ((service-id (+ (var-get service-counter) u1)))
    (asserts! (> capacity u0) ERR-INVALID-PARAMETERS)
    (asserts! (> price-per-kwh u0) ERR-INVALID-PARAMETERS)

    (map-set grid-services
      { service-id: service-id }
      {
        service-type: service-type,
        provider: tx-sender,
        capacity: capacity,
        price-per-kwh: price-per-kwh,
        active: true,
        created-at: block-height
      }
    )
    (var-set service-counter service-id)
    (ok service-id)
  )
)

(define-public (use-grid-service (service-id uint) (energy-amount uint))
  (let (
    (service (unwrap! (map-get? grid-services { service-id: service-id }) ERR-SERVICE-NOT-FOUND))
    (usage-id (+ (var-get usage-counter) u1))
    (cost (* energy-amount (get price-per-kwh service)))
  )
    (asserts! (get active service) ERR-INVALID-PARAMETERS)
    (asserts! (<= energy-amount (get capacity service)) ERR-INVALID-PARAMETERS)

    (map-set service-usage
      { usage-id: usage-id }
      {
        service-id: service-id,
        consumer: tx-sender,
        energy-used: energy-amount,
        cost: cost,
        timestamp: block-height
      }
    )
    (var-set usage-counter usage-id)
    (ok cost)
  )
)

(define-public (deactivate-service (service-id uint))
  (let ((service (unwrap! (map-get? grid-services { service-id: service-id }) ERR-SERVICE-NOT-FOUND)))
    (asserts! (is-eq tx-sender (get provider service)) ERR-NOT-AUTHORIZED)

    (map-set grid-services
      { service-id: service-id }
      (merge service { active: false })
    )
    (ok true)
  )
)

(define-read-only (get-grid-service (service-id uint))
  (map-get? grid-services { service-id: service-id })
)

(define-read-only (get-service-usage (usage-id uint))
  (map-get? service-usage { usage-id: usage-id })
)

(define-read-only (get-service-count)
  (var-get service-counter)
)
