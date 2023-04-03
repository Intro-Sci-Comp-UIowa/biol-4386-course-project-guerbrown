import os
import re
from svgutils.compose import *
from PIL import Image
import uuid

# Specify the input and output directories
input_directory = '~/github_local/biol-4386-course-project-guerbrown/output'
output_directory = '~/github_local/biol-4386-course-project-guerbrown/final_images'

# Expand the ~ character to the home directory path
input_directory = os.path.expanduser(input_directory)
output_directory = os.path.expanduser(output_directory)

# Loop through each file in the input directory
for filename in os.listdir(input_directory):
    # Check if the file is an SVG file
    if filename.endswith('.svg'):
        # Open the SVG file and remove the white background
        with open(os.path.join(input_directory, filename), 'r') as f:
            svg_str = f.read()
            # Find the white background rectangle using a regular expression
            svg_str = re.sub(r'<rect.*?fill="#ffffff".*?/>', '', svg_str, flags=re.DOTALL)
            svg = SVG(svg_str)
            # Generate a new file name for the modified SVG file
            new_filename = str(uuid.uuid4()) + '.svg'
            # Save the modified SVG file using the new file name
            svg.save(os.path.join(output_directory, new_filename))

        # Convert the SVG file to a PNG file
        svg_image = Image.open(os.path.join(output_directory, new_filename))
        png_filename = os.path.splitext(new_filename)[0] + '.png'
        png_filepath = os.path.join(output_directory, png_filename)
        svg_image.save(png_filepath)

