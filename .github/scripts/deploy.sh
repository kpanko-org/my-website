#!/usr/bin/env bash
set -e

echo "$SSH_PRIVATE_KEY" >private_key && chmod 600 private_key

ssh -i private_key -o StrictHostKeyChecking=no \
  "$REMOTE_USER@$REMOTE_HOST" \
  "REMOTE_PATH=\$HOME/${REMOTE_PATH}; \
  BACKUP_PATH=\$HOME/backups/\$(date +'%Y%m%d%H%M%S'); \
  mkdir -p \"\$BACKUP_PATH\"; \
  if [ -d \"\$REMOTE_PATH\" ]; then \
    cp -r \"\$REMOTE_PATH\" \"\$BACKUP_PATH\"; \
    echo \"Backup created at \$BACKUP_PATH\"; \
  else \
    echo \"Error: REMOTE_PATH '\$REMOTE_PATH' does not exist.\"; \
    exit 1; \
  fi"

rsync -avz --delete \
  -e "ssh -i private_key -o StrictHostKeyChecking=no" \
  _site/ "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"

rm -f private_key
