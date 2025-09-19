# Laravel 12 + Livewire 3 Docker Development Environment

A complete Docker development environment template for Laravel 12 with Livewire 3, including MySQL, Redis, Nginx, and Mailpit. This repository provides the Docker setup - your Laravel application will be created in the `laravel-app/` directory when you run the setup script.

## 🎯 Repository Purpose

This repository is a **Docker development environment template**. It contains:
- ✅ Docker configuration files
- ✅ Setup scripts
- ✅ Documentation
- ❌ **No Laravel application code** (created by setup script)

The `laravel-app/` directory is ignored by Git, so each project using this template will have its own Laravel application that doesn't get committed to this repository.

## 🚀 Quick Start

1. **Run the setup script:**
   ```bash
   ./setup.sh
   ```

2. **Access your application:**
   - Web Application: http://localhost:8000
   - Mailpit (Email testing): http://localhost:8025

## 📋 Services Included

- **Laravel App** (PHP 8.3 + FPM)
- **Nginx** (Web server)
- **MySQL 8.0** (Database)
- **Redis** (Cache & Sessions)
- **Mailpit** (Email testing)

## 🛠️ Manual Setup

If you prefer to set up manually:

1. **Create environment file:**
   ```bash
   cp .env.docker .env
   ```

2. **Start Docker containers:**
   ```bash
   docker-compose up -d --build
   ```

3. **Install Laravel 12:**
   ```bash
   docker-compose exec app composer create-project laravel/laravel:^12.0 . --prefer-dist
   ```

4. **Install Livewire 3:**
   ```bash
   docker-compose exec app composer require livewire/livewire:^3.0
   ```

5. **Generate application key:**
   ```bash
   docker-compose exec app php artisan key:generate
   ```

6. **Run migrations:**
   ```bash
   docker-compose exec app php artisan migrate
   ```

7. **Install and build frontend assets:**
   ```bash
   docker-compose exec app npm install
   docker-compose exec app npm run build
   ```

## 🐳 Docker Commands

### Basic Operations
```bash
# Start all services
docker-compose up -d

# Stop all services
docker-compose down

# Rebuild and start
docker-compose up -d --build

# View logs
docker-compose logs -f app
docker-compose logs -f webserver
docker-compose logs -f db
```

### Container Access
```bash
# Access app container
docker-compose exec app bash

# Run Artisan commands
docker-compose exec app php artisan migrate
docker-compose exec app php artisan make:controller ExampleController

# Run Composer commands
docker-compose exec app composer install
docker-compose exec app composer require package/name

# Run NPM commands
docker-compose exec app npm install
docker-compose exec app npm run dev
```

## 📁 Project Structure

```
Laravel/
├── laravel-app/            # Laravel application (created by setup script, ignored by git)
│   ├── app/                # Laravel's app directory (models, controllers, etc.)
│   ├── config/
│   ├── database/
│   ├── public/
│   ├── resources/
│   ├── routes/
│   ├── storage/
│   ├── vendor/
│   ├── .env
│   ├── composer.json
│   └── artisan
├── docker/                 # Docker configuration files
│   ├── nginx/
│   │   └── conf.d/
│   │       └── app.conf
│   ├── php/
│   │   └── local.ini
│   └── mysql/
│       └── my.cnf
├── docker-compose.yml      # Docker services configuration
├── Dockerfile              # PHP container configuration
├── setup.sh               # Automated setup script
├── .gitignore             # Ignores laravel-app/ directory
└── README.md              # This file
```

## 🔧 Configuration

### Database Configuration
- **Host:** db
- **Port:** 3306
- **Database:** laravel
- **Username:** laravel
- **Password:** laravel

### Redis Configuration
- **Host:** redis
- **Port:** 6379

### Mail Configuration
- **Host:** mailpit
- **Port:** 1025
- **Web Interface:** http://localhost:8025

## 🎯 Livewire 3 Features

This environment is optimized for Livewire 3 development with:
- PHP 8.3 support
- Redis for session storage
- Hot reloading support
- Optimized Nginx configuration

### Creating Livewire Components
```bash
# Create a new Livewire component
docker-compose exec app php artisan make:livewire Counter

# Create a Livewire component with view
docker-compose exec app php artisan make:livewire UserProfile --view
```

## 🐛 Troubleshooting

### Common Issues

1. **Port already in use:**
   ```bash
   # Check what's using the port
   sudo netstat -tulpn | grep :8000
   
   # Stop conflicting services or change ports in docker-compose.yml
   ```

2. **Permission issues:**
   ```bash
   # Fix file permissions
   sudo chown -R $USER:$USER .
   ```

3. **Database connection issues:**
   ```bash
   # Check if database is running
   docker-compose ps
   
   # Restart database
   docker-compose restart db
   ```

4. **Clear Laravel caches:**
   ```bash
   docker-compose exec app php artisan config:clear
   docker-compose exec app php artisan cache:clear
   docker-compose exec app php artisan route:clear
   docker-compose exec app php artisan view:clear
   ```

## 📚 Additional Resources

- [Laravel 12 Documentation](https://laravel.com/docs/12.x)
- [Livewire 3 Documentation](https://livewire.laravel.com/docs/quickstart)
- [Docker Compose Documentation](https://docs.docker.com/compose/)

## 🤝 Contributing

Feel free to submit issues and enhancement requests!

## 📄 License

This project is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
