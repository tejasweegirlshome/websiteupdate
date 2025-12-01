# Images Types Suported
This project supports different types of images based on their filenames. `jpg`, `png`, `gif`, and `svg` are supported.
Videos like `mp4`, `mov`, `avi` are not supported.


# How to name image files in images/
Images are filtered reading the filename.
If the file name has `-filter-rooms-xyz`, the filter would be `rooms`.

# How to add new image with filters
To add a new image with filters, follow these steps:
1. Place the image file in the `images/` directory.
2. Name the file using the following convention:
   `image-name-filter-<filter1>-<filter2>-...-<filterN>.<extension>`
   - For example: `living-room-filter-rooms-modern.jpg`
3. Ensure the file extension is one of the supported types: `jpg`, `png`, `gif`, `svg`.