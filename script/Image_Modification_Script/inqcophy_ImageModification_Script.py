import os
import cairosvg
from xml.etree import ElementTree

# Specify the directory containing the SVG images
input_dir = '/home/guerbrown/github_local/biol-4386-course-project-guerbrown/output'
output_dir = os.path.expanduser('~/github_local/biol-4386-course-project-guerbrown/final_images')

# Make sure output directory exists
os.makedirs(output_dir, exist_ok=True)

# Loop through each SVG file in the input directory
for filename in os.listdir(input_dir):
    if filename.endswith('.svg'):

        # Define the input and output filenames
        input_file = os.path.join(input_dir, filename)
        output_file = os.path.join(output_dir, filename.replace('.svg', '_no_bg_.png'))

        # Load the SVG file and remove the background
        with open(input_file, 'r') as svg_file:
            svg_data = svg_file.read()
            tree = ElementTree.fromstring(svg_data)
            tree.attrib['style'] = 'background-color:none'

        # Save the modified SVG as a PNG
        cairosvg.svg2png(bytestring=ElementTree.tostring(tree), write_to=output_file)

