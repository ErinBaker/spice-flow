Below is an updated **README** reflecting the script’s new capabilities and changes:

---

# spice-flow.sh

A flexible coordinate generator that enriches geographic points with random attributes. Like the spice melange flowing through the desert planet Arrakis, this script streams forth coordinates with mystical properties.  

## Usage

```bash
./spice-flow.sh <number_of_records> <number_of_attributes>
```

### Arguments

- `number_of_records`: How many coordinate pairs to generate  
- `number_of_attributes`: How many random values (0-9) to append to each coordinate pair  

### Example

```bash
./spice-flow.sh 100 10
```

This generates 100 records, each containing:
- A WGS 84 latitude (-90° to 90°)  
- A WGS 84 longitude (-180° to 180°)  
- 10 random integers (0-9)

### Attribute Naming

Each attribute field now has a unique or semi-unique label drawn from a Dune-themed word list.

### Output Format

The script saves results to a CSV file, named according to a random Dune-themed word, the total number of records, and the total number of attributes. For instance:

```
<random_dune_word>_<records>_<attributes>.csv
```

Each row consists of:
```
latitude,longitude,attr1,attr2,attr3,...
```
With latitude/longitude in decimal degrees and attributes as random integers.  

### Coordinate System

Coordinates are generated in WGS 84 (World Geodetic System 1984) format, the standard used by GPS and modern mapping applications.  
- Latitude: -90° to 90° (negative for South, positive for North)  
- Longitude: -180° to 180° (negative for West, positive for East)  
- Three decimal places precision.

### Additional Features

**Execution Time Tracking**  
   The script prints how many milliseconds it took to complete the process.

## Requirements

- Bash shell  
- awk  

## Performance

The script times its own execution in milliseconds and displays a summary upon completion, including how many records and attribute columns were generated, the final CSV filename, and the total run time.  