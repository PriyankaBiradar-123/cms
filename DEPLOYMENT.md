# Deployment Guide - Railway.app

## Quick Setup (5 minutes)

### Step 1: Initialize Git Repository
```bash
cd c:\xampp\htdocs\cms
git init
git add .
git commit -m "Initial commit"
```

### Step 2: Create Railway Account & Deploy
1. Go to https://railway.app
2. Sign up with GitHub (recommended)
3. Click "New Project"
4. Select "Deploy from GitHub"
5. Authorize Railway to access your GitHub account
6. Select your CMS repository
7. Railway will automatically detect Dockerfile and deploy

### Step 3: Configure Environment Variables in Railway Dashboard
After deployment:
1. Go to your Railway project
2. Click on the deployed service
3. Go to "Variables" tab
4. Add these variables:
   ```
   DB_SERVER=mysql.railway.internal
   DB_USERNAME=root
   DB_PASSWORD=(set by Railway MySQL addon)
   DB_NAME=cms_db
   BASE_URL=https://(your-railway-url).railway.app/
   PORT=8080
   ```

### Step 4: Add MySQL Database
1. In Railway dashboard, click "New Service"
2. Select "MySQL"
3. This will auto-populate DB credentials
4. Import database: Use [railroad CLI](https://docs.railway.app/cli/init) or phpMyAdmin

### Step 5: Get Your Public URL
- Your app URL will be: `https://your-project-name.railway.app`
- Shared with anyone via this URL

## Alternative: Deploy to InfinityFree (Completely Free)

If you prefer true free hosting without credit requirements:

1. Go to https://infinityfree.com
2. Create account and select free hosting plan
3. Upload files via FTP
4. Import database via phpMyAdmin (included)
5. Update initialize.php with their database credentials

## Database Import

### Option A: Via Railway Dashboard
1. Use Database Viewer in Railway
2. Import SQL file or use phpMyAdmin URL provided

### Option B: Command Line (after deployment)
```bash
mysql -h mysql.railway.internal -u root -p cms_db < database/cms_db.sql
```

## Troubleshooting

**Database Connection Error:**
- Verify DB credentials in Railway Variables tab
- Ensure MySQL service is running
- Check firewall rules

**Port Issues:**
- Railway automatically assigns PORT env variable
- Dockerfile uses 8080
- Update php server config if needed

**File Upload Issues:**
- Ensure `/uploads` directory is writable
- Set proper permissions: `chmod 777 uploads/`

## Local Testing Before Deploy
```bash
# Test locally first
php -S localhost:8000
# Visit http://localhost:8000
```

## Support
- Railway Docs: https://docs.railway.app
- GitHub Issues: Track deployment problems there
