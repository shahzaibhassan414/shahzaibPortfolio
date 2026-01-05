# First, make sure you're in the project directory
cd path/to/shahzaibPortfolio

# Create the build.sh file (if you haven't already)
# Copy the script content into build.sh

# Add the file to Git
git add build.sh

# Make it executable
git update-index --chmod=+x build.sh

# Verify it's now executable (should show 100755)
git ls-files --stage build.sh

# Commit the changes
git commit -m "Add executable build.sh for Vercel deployment"

# Push to GitHub
git push origin main
```

## Quick verification:

After running `git ls-files --stage build.sh`, you should see something like:
```
100755 [hash] 0	build.sh