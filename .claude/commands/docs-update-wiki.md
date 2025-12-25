# Update Wiki

Update the project wiki with current documentation and code changes.

## Instructions

1. **Scan for Changes**
   - Check for modified documentation files in `docs/`
   - Review CHANGELOG.md for recent updates
   - Identify new packages or features added

2. **Update Wiki Pages**
   - Sync README.md content to wiki Home page
   - Update API documentation from package docstrings
   - Update architecture documentation if structure changed

3. **Generate Content**
   For each modified area, update the corresponding wiki section:

   ```bash
   # Check what changed
   git diff --name-only HEAD~5 -- docs/ packages/ apps/
   ```

4. **Wiki Structure**
   ```
   wiki/
   ├── Home.md              # Project overview (from README)
   ├── Getting-Started.md   # Quick start guide
   ├── Architecture.md      # System architecture
   ├── Packages/
   │   ├── Core.md          # monorepo-core docs
   │   ├── Shared.md        # monorepo-shared docs
   │   └── Config.md        # monorepo-config docs
   ├── Development/
   │   ├── Setup.md         # Development setup
   │   ├── Testing.md       # Testing guidelines
   │   └── Contributing.md  # Contribution guide
   └── Deployment/
       ├── Docker.md        # Docker deployment
       └── Kubernetes.md    # K8s deployment
   ```

5. **Sync Commands**
   ```bash
   # Copy updated docs to wiki
   cp README.md wiki/Home.md
   cp CONTRIBUTING.md wiki/Development/Contributing.md

   # Generate API docs
   make api-docs
   ```

6. **Commit Wiki Changes**
   ```bash
   cd wiki
   git add -A
   git commit -m "docs(wiki): sync with main repository"
   git push origin master
   ```

## Checklist

- [ ] Documentation files reviewed
- [ ] Package READMEs synced
- [ ] API documentation generated
- [ ] Wiki pages updated
- [ ] Changes committed and pushed
