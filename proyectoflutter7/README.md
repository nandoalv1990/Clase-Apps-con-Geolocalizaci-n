# proyectoflutter7

A new Flutter project.

## API Keys Configuration

### MapTiler (Desktop/Flutter Map)

MapTiler provides tiles for the flutter_map. Never store API keys in the repository.

#### Setup (recommended: local config file)

1. **Copy the template to your local config:**
   ```bash
   cp config/app_config.json.template config/app_config.json
   ```

2. **Edit `config/app_config.json` and add your MapTiler key:**
   ```json
   {
     "maptiler_key": "YOUR_MAPTILER_KEY_HERE"
   }
   ```

3. **Get a free MapTiler key:**
   - Visit https://cloud.maptiler.com/account/keys/
   - Create or use an existing key
   - Paste it in `config/app_config.json`

4. **`config/app_config.json` is in `.gitignore` — it will NOT be committed.**

#### Usage

The app automatically loads the config when you run it:

```bash
flutter run -d linux
```

The app will:
1. Try to read `config/app_config.json` (if it exists)
2. Fall back to the `MAPTILER_KEY` environment variable (if set)
3. If neither is found, use OSM tiles (free but rate-limited)

#### Alternative: Environment variable

You can also set the key via environment:

```bash
export MAPTILER_KEY=YOUR_MAPTILER_KEY
flutter run -d linux
```

### Google Maps (Android)
API key: AIzaSyCcMfDBE07yxVLfChOrfnYPfSrSCoz4zdE

---

## Security Note

**NEVER commit API keys to the repository.**

If you accidentally committed a key (this repo had one exposed), rotate the key
immediately in MapTiler and remove it from git history:

```bash
# Option 1: Use git filter-repo (recommended)
git filter-repo --invert-paths --paths README.md

# Option 2: Use BFG Repo-Cleaner
bfg --delete-files YOUR_FILE_WITH_KEY
git reflog expire --expire=now --all && git gc --prune=now --aggressive
```

Then force-push:

```bash
git push --force origin main
```

---

## Flutter Setup

### Install dependencies
```bash
flutter pub add flutter_map
flutter pub add latlong2
flutter pub add package_info_plus
```

### Run the app
```bash
flutter run -d linux
```
