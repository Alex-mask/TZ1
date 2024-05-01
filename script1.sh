#!/bin/bash


if [ $# -ne 2 ]; then
    echo "Использование: $0 <входная директория> <выходная директория>"
    exit 1
fi

input_dir="$1"
output_dir="$2"


if [ ! -d "$input_dir" ] || [ ! -d "$output_dir" ]; then
    echo "Оба параметра должны быть существующими директориями."
    exit 1
fi


mycp () {
    local source="$1"
    local target_dir="$2"
    local filename=$(basename -- "$source")
    local target="$target_dir/$filename"
    local name="${filename%.*}"
    local extension="${filename##*.}"
    
    
    local counter=0
    while [ -e "$target" ]; do
        
        ((counter++))
        if [[ "$filename" = *.* ]]; then
            target="$target_dir/$name-$counter.$extension"
        else
            target="$target_dir/$name-$counter"
        fi
    done
    
    
    cp "$source" "$target"
}


export -f mycp


find "$input_dir" -type f -exec bash -c 'mycp "$0" "$1"' {} "$output_dir" \;

exit 0
