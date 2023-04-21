import os
from lxml import etree
from cairosvg import svg2png
from PIL import Image
from svgwrite import Drawing
import svgutils

def remove_white_background(svg_file):
    tree = etree.parse(svg_file)
    root = tree.getroot()

    for element in root.iter('*'):
        if 'style' in element.attrib:
            if 'fill:#ffffff' in element.attrib['style']:
                element.attrib['style'] = element.attrib['style'].replace('fill:#ffffff', 'fill-opacity:0')
    return tree

input_dir = "/home/guerbrown/github_local/biol-4386-course-project-guerbrown/output"
output_dir = "/home/guerbrown/github_local/biol-4386-course-project-guerbrown/final_images"

if not os.path.exists(output_dir):
    os.makedirs(output_dir)

for file in os.listdir(input_dir):
    if file.endswith(".svg"):
        input_file_path = os.path.join(input_dir, file)
        output_file_path = os.path.join(output_dir, file)
        output_png_file_path = os.path.join(output_dir, os.path.splitext(file)[0] + "_no_bg.png")

        processed_tree = remove_white_background(input_file_path)

        # Save the modified SVG
        with open(output_file_path, "wb") as f:
            f.write(etree.tostring(processed_tree, pretty_print=True, xml_declaration=True, encoding="UTF-8"))

        # Convert the modified SVG to PNG
        svg2png(bytestring=etree.tostring(processed_tree), write_to=output_png_file_path)

print("Processing completed.")

