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

Output format: `15.470,32.233,3,3,6,4,8,4,2,0,8,7`

### Coordinate System
The script generates coordinates in the WGS 84 (World Geodetic System 1984) format, which is the standard used by GPS and most modern mapping applications. Coordinates are decimal degrees with three decimal places precision:
- Latitude: -90° to 90° (negative for South, positive for North)
- Longitude: -180° to 180° (negative for West, positive for East)

### Output
The script saves results to a uniquely named file: `<spice>_<records>_<attributes>-<count>.txt`

## Requirements
- Bash shell
- awk

## Performance
The script includes basic execution time tracking and will display a summary upon completion.
