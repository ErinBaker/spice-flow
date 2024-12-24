#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <number_of_records> <number_of_attributes>"
    echo "Example: $0 100 10 (generates 100 records, each with coordinates and 10 random values)"
    exit 1
fi

# Record start time in nanoseconds for millisecond calculation later
start_time=$(date +%s%N)

# Extract the arguments
num_records=$1
num_attributes=$2

# Expanded array of Dune-themed words for both filename and attributes
dune_words=(
    "arrakis" "atreides" "harkonnen" "fremen" "sietch"
    "melange" "sandworm" "spice" "shai_hulud" "fedaykin"
    "crysknife" "ornithopter" "kwisatz" "muaddib" "sardaukar"
    "ghanima" "leto" "duncan" "stilgar" "chani"
    "lady_jessica" "alia" "thufir" "giedi_prime" "caladan"
    "ecaz" "holtzman" "choran" "lisan_al_gaib" "tleilaxu"
    "stillsuit" "chaumas" "chaumurky" "weyrling" "raxil"
)

###############################################################################
# Function: shuffle_array
# Shuffles the elements of an array in place (Fisher-Yates shuffle).
# Usage:
#   shuffle_array dune_words
#   (after this call, the dune_words array is shuffled in place)
###############################################################################
shuffle_array() {
  local -n arr=$1
  local i j temp
  for ((i=${#arr[@]}-1; i>0; i--)); do
    j=$((RANDOM % (i+1)))
    temp="${arr[$i]}"
    arr[$i]="${arr[$j]}"
    arr[$j]="$temp"
  done
}

# Shuffle the dune_words array once to ensure initial uniqueness
shuffle_array dune_words

# Generate a random Dune word from the shuffled array for the filename prefix
random_index=$((RANDOM % ${#dune_words[@]}))
dune_word=${dune_words[$random_index]}

# Generate filename with the random Dune word
output_file="${dune_word}_${num_records}_${num_attributes}.csv"

# If file exists, keep trying different random words
while [ -e "$output_file" ]; do
    random_index=$((RANDOM % ${#dune_words[@]}))
    dune_word=${dune_words[$random_index]}
    output_file="${dune_word}_${num_records}_${num_attributes}.csv"
done

###############################################################################
# Build an array of unique attribute names.
# If num_attributes <= length of dune_words, just use the first subset.
# Otherwise, for the excess, generate concatenated names that haven't been used.
###############################################################################
declare -a attribute_names=()
declare -A used_names=()

# Fill attribute_names from dune_words directly until we run out
# or until we have enough for num_attributes.
for name in "${dune_words[@]}"; do
    if [ "${#attribute_names[@]}" -lt "$num_attributes" ]; then
        attribute_names+=("$name")
        used_names["$name"]=1
    else
        break
    fi
done

# If still need more names, generate them by concatenating two random words
while [ "${#attribute_names[@]}" -lt "$num_attributes" ]; do
    word1=${dune_words[$((RANDOM % ${#dune_words[@]}))]}
    word2=${dune_words[$((RANDOM % ${#dune_words[@]}))]}
    new_name="${word1}-${word2}"

    # Make sure this new_name is unique
    if [ -z "${used_names[$new_name]}" ]; then
        attribute_names+=("$new_name")
        used_names["$new_name"]=1
    fi
done

# Construct the header row
header="x,y"
for attr_name in "${attribute_names[@]}"; do
    header="${header},${attr_name}"
done
echo "$header" > "$output_file"

# Append generated data to the file
awk -v records="$num_records" -v attrs="$num_attributes" '
BEGIN {
    srand();
    for(i=1; i<=records; i++) {
        # Generate coordinates:
        # x in [-180, 180], y in [-90, 90]
        x = -180 + rand() * 360;
        y = -90 + rand() * 180;

        printf "%.3f,%.3f", x, y;
        
        # Add requested number of random integer attributes (0-9)
        for(j=1; j<=attrs; j++) {
            printf ",%d", int(rand() * 10);
        }
        printf "\n";
    }
}' >> "$output_file"

# Record end time in nanoseconds
end_time=$(date +%s%N)

# Calculate duration in milliseconds
duration_ms=$(( (end_time - start_time) / 1000000 ))

# Display summary
echo "He who controls the spice controls the universe."
echo "Summary:"
echo "Records saved to '$output_file'"
echo "Number of records generated: $num_records"
echo "Number of random attributes per record: $num_attributes"
echo "Script execution time: $duration_ms milliseconds"
