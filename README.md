# Forecastr API

A Rails API application for generating forecasts using Prophet.

## Development Setup

### Prerequisites

- Ruby 3.2.2
- PostgreSQL
- Bundler

### Installation

1. Clone the repository:

```bash
git clone https://github.com/your-username/forecastr.git
cd forecastr
```

2. Install dependencies:

```bash
bundle install
```

3. Set up the database:

```bash
rails db:create db:migrate
```

4. Start the development server:

```bash
rails server
```

The API will be available at `http://localhost:3000`

## API Documentation

### Authentication

All API endpoints (except user creation) require authentication using an API key. Include the API key in the `X-API-Key` header for all requests.

### Endpoints

#### Create User

```bash
curl -X POST http://localhost:3000/users \
  -H "Content-Type: application/json" \
  -d '{
    "user": {
      "email_address": "user@example.com",
      "password": "your-password",
      "password_confirmation": "your-password"
    }
  }'
```

Response:

```json
{
  "status": "success",
  "message": "User created successfully",
  "api_key": "generated-api-key"
}
```

#### Create Forecast

```bash
curl -X POST http://localhost:3000/forecasts \
  -H "X-API-Key: 6c9ded4afdeda42017d4e12eaff59fd77b6219e982d2d8a4dbf6f901d445b3ef" \
  -H "Content-Type: application/json" \
  -d '{
    "data": {
      "2024-01-01": 1250,
      "2024-01-08": 1320,
      "2024-01-15": 1180,
      "2024-01-22": 1450,
      "2024-01-29": 1280,
      "2024-02-05": 1520,
      "2024-02-12": 1380,
      "2024-02-19": 1620,
      "2024-02-26": 1480,
      "2024-03-04": 1750,
      "2024-03-11": 1580,
      "2024-03-18": 1820,
      "2024-03-25": 1680,
      "2024-04-01": 1950,
      "2024-04-08": 1780
    }
  }'
```

Response:

```json
{
  "forecast": {
    "predictions": {
      "2024-04-15": 1850,
      "2024-04-22": 1920,
      "2024-04-29": 1980,
      "2024-05-06": 2050,
      "2024-05-13": 2120,
      "2024-05-20": 2180,
      "2024-05-27": 2250,
      "2024-06-03": 2320
    },
    "confidence_intervals": {
      "2024-04-15": [1750, 1950],
      "2024-04-22": [1820, 2020],
      "2024-04-29": [1880, 2080],
      "2024-05-06": [1950, 2150],
      "2024-05-13": [2020, 2220],
      "2024-05-20": [2080, 2280],
      "2024-05-27": [2150, 2350],
      "2024-06-03": [2220, 2420]
    }
  }
}
```

#### Manage API Key

```bash
# Get current API key
curl -X GET http://localhost:3000/api_key \
  -H "X-API-Key: your-api-key"

# Regenerate API key
curl -X PATCH http://localhost:3000/api_key \
  -H "X-API-Key: your-api-key"
```

## Development Guidelines

### Code Style

- Follow Ruby style guide
- Use Rubocop for linting
- Write tests for all new features

### Database

- Always use migrations for database changes
- Never modify schema.rb directly
- Use `rails generate migration` for new migrations

### API Design

- Keep controllers thin
- Use service objects for business logic
- Return appropriate HTTP status codes
- Use JSON for all responses

### Security

- Never commit sensitive data
- Use environment variables for secrets
- Validate all user input
- Use strong parameters

## Testing

Run the test suite:

```bash
rails test
```

## Deployment

The application is configured for deployment using Kamal. See `config/deploy.yml` for deployment configuration.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
