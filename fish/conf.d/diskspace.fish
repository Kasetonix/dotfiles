function diskspace
  echo "TOTAL >$(df -h / --output=size | tail -n 1)"
  echo "USED  >$(df -h / --output=used | tail -n 1)"
  echo "FREE  >$(df -h / --output=avail | tail -n 1)"
  echo "%USED >$(df -h / --output=pcent | tail -n 1)"
end
