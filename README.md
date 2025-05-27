# Blockchain-Based Renewable Energy Storage Network

A comprehensive smart contract system for managing distributed renewable energy storage facilities on the Stacks blockchain using Clarity.

## Overview

This project implements a decentralized network for renewable energy storage management, featuring facility verification, network coordination, grid services, optimization algorithms, and revenue sharing mechanisms.

## Architecture

### Smart Contracts

1. **Storage Facility Contract** (`storage-facility.clar`)
    - Validates energy storage installations
    - Manages facility registration and verification
    - Tracks capacity and charge levels

2. **Network Coordinator Contract** (`network-coordinator.clar`)
    - Manages distributed storage network operations
    - Handles energy requests and fulfillment
    - Monitors network status and capacity

3. **Grid Services Contract** (`grid-services.clar`)
    - Provides system-wide storage services
    - Manages service registration and usage
    - Tracks service consumption and costs

4. **Optimization Contract** (`optimization.clar`)
    - Maximizes network efficiency through algorithms
    - Tracks facility performance metrics
    - Provides optimization recommendations

5. **Revenue Sharing Contract** (`revenue-sharing.clar`)
    - Distributes network benefits among participants
    - Manages revenue pools and participant shares
    - Calculates contribution-based payouts

## Features

### Storage Facility Management
- Facility registration with location and capacity
- Verification system for legitimate installations
- Real-time charge level monitoring
- Owner-controlled facility updates

### Network Coordination
- Energy request submission and fulfillment
- Network capacity tracking
- Distributed coordination mechanisms
- Request status management

### Grid Services
- Service provider registration
- Usage tracking and billing
- Service activation/deactivation
- Cost calculation based on consumption

### Optimization Engine
- Efficiency scoring algorithms
- Performance metrics tracking
- Automated recommendations
- Facility utilization analysis

### Revenue Distribution
- Participant contribution scoring
- Revenue pool management
- Automated distribution mechanisms
- Transparent payout tracking

## Getting Started

### Prerequisites
- Stacks blockchain development environment
- Clarity CLI tools
- Node.js for testing

### Installation

1. Clone the repository
   \`\`\`bash
   git clone <repository-url>
   cd renewable-energy-storage
   \`\`\`

2. Install dependencies
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests
   \`\`\`bash
   npm test
   \`\`\`

### Deployment

Deploy contracts to Stacks testnet:

\`\`\`bash
clarinet deploy --testnet
\`\`\`

## Usage Examples

### Register a Storage Facility
\`\`\`clarity
(contract-call? .storage-facility register-facility "Solar Farm A, CA" u1000)
\`\`\`

### Submit Energy Request
\`\`\`clarity
(contract-call? .network-coordinator submit-energy-request u500 u100)
\`\`\`

### Register Grid Service
\`\`\`clarity
(contract-call? .grid-services register-grid-service "Peak Load Management" u2000 u50)
\`\`\`

### Run Optimization
\`\`\`clarity
(contract-call? .optimization run-optimization "Load Balancing" "facility-data-input")
\`\`\`

### Add Revenue Participant
\`\`\`clarity
(contract-call? .revenue-sharing add-participant 'SP1234... u750)
\`\`\`

## Testing

The project includes comprehensive tests using Vitest:

- Unit tests for each contract function
- Integration tests for cross-contract interactions
- Edge case and error condition testing

Run tests with:
\`\`\`bash
npm test
\`\`\`

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## Security Considerations

- All contracts implement proper authorization checks
- Input validation prevents invalid data entry
- Error handling ensures graceful failure modes
- Access control restricts sensitive operations

## License

MIT License - see LICENSE file for details

## Support

For questions or support, please open an issue in the repository.
