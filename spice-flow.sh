#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <number_of_records> <number_of_attributes>"
    echo "Example: $0 100 10 (generates 100 records, each with coordinates and 10 random values)"
    exit 1
fi

# Record start time
start_time=$(date +%s)

# Extract the arguments
num_records=$1
num_attributes=$2

# Array of Dune-themed words for filenames
dune_words=(
    "arrakis" "atreides" "harkonnen" "fremen" "sietch" 
    "melange" "sandworm" "spice" "shai_hulud" "fedaykin" 
    "crysknife" "ornithopter" "kwisatz" "muaddib" "sardaukar"
    "ghanima" "leto" "duncan" "stilgar" "chani"
)

# Get a random word from the array
random_index=$((RANDOM % ${#dune_words[@]}))
dune_word=${dune_words[$random_index]}

# Generate filename with random Dune word
output_file="${dune_word}_${num_records}_${num_attributes}.csv"

# If file exists, keep trying different random words
while [ -e "$output_file" ]; do
    random_index=$((RANDOM % ${#dune_words[@]}))
    dune_word=${dune_words[$random_index]}
    output_file="${dune_word}_${num_records}_${num_attributes}.csv"
done

# Modified awk command to handle variable number of attributes
awk -v records="$num_records" -v attrs="$num_attributes" '
BEGIN {
    srand();
    for(i=1; i<=records; i++) {
        # Generate coordinates
        lat = -90 + rand() * 180;  # Range: -90 to 90
        lon = -180 + rand() * 360; # Range: -180 to 180
        
        # Start the line with coordinates
        printf "%.3f,%.3f", lat, lon;
        
        # Add requested number of random attributes
        for(j=1; j<=attrs; j++) {
            printf ",%d", int(rand() * 10);  # Random integer 0-9
        }
        printf "\n";
    }
}' > "$output_file"

# Calculate and display the duration
end_time=$(date +%s)
duration=$((end_time - start_time))

# Display summary
echo "Summary:"
echo "Records saved to '$output_file'"
echo "Number of records generated: $num_records"
echo "Number of random attributes per record: $num_attributes"
echo "Script execution time: $duration seconds"