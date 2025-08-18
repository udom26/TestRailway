FROM php:8.2-fpm

# ติดตั้ง system dependencies ที่จำเป็น พร้อม clean cache apt เพื่อลดขนาด image
RUN apt-get update && apt-get install -y \
    libonig-dev \
    libzip-dev \
    zip \
    unzip \
    curl \
    git \
    vim \
    libpq-dev \
    default-mysql-client \
    && docker-php-ext-install pdo pdo_mysql mbstring opcache \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# ติดตั้ง Composer (copy มาจาก official composer image)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# ตั้ง working directory ใน container
WORKDIR /var/www/html

# คัดลอกไฟล์ source code ทั้งหมดลงใน container
COPY . .

# ให้สิทธิ์ไฟล์และโฟลเดอร์แก่ www-data (user ที่ php-fpm ใช้)
RUN chown -R www-data:www-data /var/www/html

# ถ้ามี composer.json ให้รัน composer install (ถ้าต้องการ)
# RUN composer install --no-dev --optimize-autoloader

# เปิดพอร์ต ถ้าจำเป็น (PHP-FPM default ใช้ port 9000)
EXPOSE 9000

# คำสั่งเริ่มต้น container (php-fpm จะรันอยู่แล้วตาม image php-fpm)
CMD ["php-fpm"]
