#!/bin/bash

# Laravel 12 + Livewire 3 Docker Development Environment Setup Script

echo "🚀 Setting up Laravel 12 + Livewire 3 Docker Development Environment..."

# Create laravel-app directory if it doesn't exist
if [ ! -d laravel-app ]; then
    echo "📁 Creating laravel-app directory..."
    mkdir -p laravel-app
fi

# Create .env file if it doesn't exist
if [ ! -f laravel-app/.env ]; then
    echo "📝 Creating .env file..."
    cat > laravel-app/.env << 'EOF'
APP_NAME=Laravel
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost:8000

LOG_CHANNEL=stack
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=laravel
DB_PASSWORD=laravel

BROADCAST_DRIVER=log
CACHE_DRIVER=redis
FILESYSTEM_DISK=local
QUEUE_CONNECTION=redis
SESSION_DRIVER=redis
SESSION_LIFETIME=120

MEMCACHED_HOST=127.0.0.1

REDIS_HOST=redis
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=smtp
MAIL_HOST=mailpit
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="${APP_NAME}"

AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=
AWS_USE_PATH_STYLE_ENDPOINT=false

PUSHER_APP_ID=
PUSHER_APP_KEY=
PUSHER_APP_SECRET=
PUSHER_HOST=
PUSHER_PORT=443
PUSHER_SCHEME=https
PUSHER_APP_CLUSTER=mt1

VITE_PUSHER_APP_KEY="${PUSHER_APP_KEY}"
VITE_PUSHER_HOST="${PUSHER_HOST}"
VITE_PUSHER_PORT="${PUSHER_PORT}"
VITE_PUSHER_SCHEME="${PUSHER_SCHEME}"
VITE_PUSHER_APP_CLUSTER="${PUSHER_APP_CLUSTER}"
EOF
    echo "✅ .env file created!"
else
    echo "ℹ️  .env file already exists, skipping..."
fi

# Build and start Docker containers
echo "🐳 Building and starting Docker containers..."
docker-compose up -d --build

# Wait for database to be ready
echo "⏳ Waiting for database to be ready..."
sleep 10

# Install Laravel 12 if not already installed
if [ ! -f laravel-app/composer.json ]; then
    echo "📦 Installing Laravel 12..."
    # Create Laravel project directly in the app directory
    docker-compose exec app composer create-project laravel/laravel:^12.0 /var/www --prefer-dist
    
    # Install Livewire 3
    echo "⚡ Installing Livewire 3..."
    docker-compose exec app composer require livewire/livewire:^3.0
    
    # Generate application key
    echo "🔑 Generating application key..."
    docker-compose exec app php artisan key:generate
    
    # Run migrations
    echo "🗄️  Running database migrations..."
    docker-compose exec app php artisan migrate
    
    # Install Node.js dependencies
    echo "📦 Installing Node.js dependencies..."
    docker-compose exec app npm install
    
    # Build assets
    echo "🎨 Building frontend assets..."
    docker-compose exec app npm run build
    
    echo "✅ Laravel 12 + Livewire 3 setup complete!"
else
    echo "ℹ️  Laravel project already exists, skipping installation..."
    
    # Install dependencies
    echo "📦 Installing/updating dependencies..."
    docker-compose exec app composer install
    
    # Install Node.js dependencies if package.json exists
    if [ -f laravel-app/package.json ]; then
        docker-compose exec app npm install
    fi
    
    # Generate application key if not set
    if ! grep -q "APP_KEY=base64:" laravel-app/.env; then
        echo "🔑 Generating application key..."
        docker-compose exec app php artisan key:generate
    fi
    
    # Run migrations
    echo "🗄️  Running database migrations..."
    docker-compose exec app php artisan migrate
fi

echo ""
echo "🎉 Setup complete! Your Laravel 12 + Livewire 3 development environment is ready!"
echo ""
echo "📋 Available services:"
echo "   🌐 Web Application: http://localhost:8000"
echo "   📧 Mailpit: http://localhost:8025"
echo "   🗄️  MySQL: localhost:3306"
echo "   🔴 Redis: localhost:6379"
echo ""
echo "🛠️  Useful commands:"
echo "   docker-compose up -d          # Start all services"
echo "   docker-compose down           # Stop all services"
echo "   docker-compose exec app bash  # Access app container"
echo "   docker-compose logs -f app    # View app logs"
echo ""
echo "Happy coding! 🚀"
