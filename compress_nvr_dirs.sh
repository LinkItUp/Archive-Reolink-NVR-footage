#!/bin/sh

BASE_DIR="/your/path/here"
XZ_THREADS=8

get_camera_name() {
  case "$1" in
    "NVR_00") echo "Flur" ;;
    "NVR_01") echo "Lager" ;;
    *) echo "$1" ;;
  esac
}

rename_videos_in_dir() {
  dir="$1"
  find "$dir" -type f -name "*.mp4" | while read -r filepath; do
    filename=$(basename "$filepath")
    cleaned=$(echo "$filename" | tr -d ' ')
    if echo "$cleaned" | grep -Eq '^NVR_[0-9]{2}_[0-9]{14}\.mp4$'; then
      cam_code=$(echo "$cleaned" | cut -d'_' -f1,2)
      datetime=$(echo "$cleaned" | cut -d'_' -f3 | cut -d'.' -f1)
      year=${datetime:0:4}
      month=${datetime:4:2}
      day=${datetime:6:2}
      hour=${datetime:8:2}
      minute=${datetime:10:2}
      cam_name=$(get_camera_name "$cam_code")
      new_name="${cam_name} ${hour}.${minute}-${day}.${month}.${year:2:2}.mp4"
      new_path="$(dirname "$filepath")/$new_name"
      echo "Renaming '$filename' to '$new_name'"
      mv "$filepath" "$new_path"
    else
      echo "Skipping invalid file: $filename"
    fi
  done
}

find "$BASE_DIR" -mindepth 1 -maxdepth 1 -type d -mtime +0 | while read -r dir; do
  dir_name=$(basename "$dir")
  archive_path="${BASE_DIR}/${dir_name}.tar.xz"
  echo "Processing folder: $dir"
  rename_videos_in_dir "$dir"
  if tar -cf - "$dir" | xz -T"$XZ_THREADS" -9 -c > "$archive_path"; then
    echo "Compression successful: $archive_path"
    echo "Deleting original folder: $dir"
    rm -rf "$dir"
  else
    echo "Compression failed for: $dir" >&2
  fi
done