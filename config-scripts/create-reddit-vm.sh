yc compute instance create \
  --name vm-from-image \
  --folder-id=b1gbj6r7clnrmifr988p
  --zone ru-central1-a \
  --create-boot-disk name=disk1,size=5,image-id=fd88sfr4itgrb19srt81 \
  --public-ip \
  --ssh-key ~/.ssh/id_rsa.pub