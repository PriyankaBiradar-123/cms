# Deployment Guide

This repository includes deployment support for:
- Local XAMPP / Apache + MySQL
- Docker
- Railway.app using the provided `Dockerfile`

## Important files
- `Dockerfile` - builds the PHP/Apache application image
- `railway.json` - Railway deployment configuration
- `.env.example` - environment variable example
- `.gitignore` - ignores `.env`, logs, uploads, and temp files
- `initialize.php` - loads `.env` and environment variables
- `classes/DBConnection.php` - connects to MySQL using environment values

## Environment variables
Create a `.env` file in the repository root. Example contents:

```ini
DB_SERVER=localhost
DB_USERNAME=root
DB_PASSWORD=
DB_NAME=cms_db
BASE_URL=http://localhost/cms/
PORT=8080
```

Notes:
- `BASE_URL` must end with a trailing slash.
- `DB_SERVER` can be `localhost`, `host.docker.internal`, or your managed database host.
- `PORT` is optional locally and useful for Docker / Railway.
- `.env` is already ignored by `.gitignore`.

## Local deployment with XAMPP
1. Copy the repository to `C:\xampp\htdocs\cms`
2. Start Apache and MySQL in XAMPP
3. Open `http://localhost/phpmyadmin`
4. Create a database named `cms_db`
5. Import `database/cms_db.sql`
6. Create a `.env` file with your local database settings
7. Open `http://localhost/cms/`

## Docker deployment
Build the Docker image and run it:

```bash
docker build -t cms-app .
docker run -d -p 8080:80 --name cms-app \
  -e BASE_URL=http://localhost:8080/ \
  -e DB_SERVER=host.docker.internal \
  -e DB_USERNAME=root \
  -e DB_PASSWORD= \
  -e DB_NAME=cms_db \
  cms-app
```

If you use a separate MySQL container, connect both containers on the same Docker network and use the MySQL container name as `DB_SERVER`.

## Railway deployment
1. Push the repository to GitHub.
2. Open `https://railway.app` and create a new project.
3. Choose "Deploy from GitHub" and select this repository.
4. Railway should detect the `Dockerfile` automatically.
5. Add a new Railway MySQL service.
6. In the Railway project, set these environment variables:

```text
BASE_URL=https://<your-project>.railway.app/
DB_SERVER=mysql.railway.internal
DB_USERNAME=root
DB_PASSWORD=<railway mysql password>
DB_NAME=cms_db
PORT=8080
```

7. Import `database/cms_db.sql` into the Railway MySQL database.
8. After deployment, Railway shows the public URL in the project dashboard. Use that URL as `BASE_URL` if you want the app to generate links properly.

## Importing the database
Use phpMyAdmin, Railway database tools, or the MySQL CLI:

```bash
mysql -h <host> -u <user> -p <db> < database/cms_db.sql
```

Example for Railway:

```bash
mysql -h mysql.railway.internal -u root -p cms_db < database/cms_db.sql
```

## Notes and troubleshooting
- Ensure `uploads/` is writable for any file upload features.
- Set `BASE_URL` to the actual public URL in production.
- If database connection fails, verify `DB_SERVER`, `DB_USERNAME`, `DB_PASSWORD`, and `DB_NAME`.
- `initialize.php` loads `.env` values and also supports environment variables from Docker/Railway.

## Quick local test without XAMPP
From the project root:

```bash
php -S localhost:8000
```

Then visit `http://localhost:8000/`
