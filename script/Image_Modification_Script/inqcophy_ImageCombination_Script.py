import os
import math
from PIL import Image
import svgwrite

# Specify the input directory and image names
input_directory = os.path.expanduser('~/github_local/biol-4386-course-project-guerbrown/output')
img1_name = 'no_bg_inqcophy_PACo_Tanglegram_guerbrown.png'
img2_name = 'no_bg_inqcophy_PACo_ResBarplot_guerbrown.png'
img3_name = 'no_bg_inqcophy_traitmodeling_oak_section_guerbrown.png'
img4_name = 'no_bg_inqcophy_traitmodeling_hairs_guerbrown.png'
img5_name = 'no_bg_inqcophy_traitmodeling_nectar_guerbrown.png'

# Load the images and resize them
images = []
for img_name in [img1_name, img2_name]:
    img_path = os.path.join(input_directory, img_name)
    with Image.open(img_path) as img:
        img = img.resize((math.ceil(img.width / 2), math.ceil(img.height / 2)))
        images.append(img)
for img_name in [img3_name, img4_name, img5_name]:
    img_path = os.path.join(input_directory, img_name)
    with Image.open(img_path) as img:
        img = img.resize((math.ceil(img.width / 3), math.ceil(img.height / 3)))
        images.append(img)

# Determine the final image size and create a new image
widths, heights = zip(*(i.size for i in images))
total_width = sum(widths)
max_height = max(heights)
new_image = Image.new('RGB', (total_width, max_height), (255, 255, 255))

# Combine the images into the new image
x_offset = 0
for img in images:
    new_image.paste(img, (x_offset, 0))
    x_offset += img.size[0]

# Save the new image as PNG
final_image_path = os.path.join(input_directory, 'inqcophy_Final_Image_guerbrown.png')
new_image.save(final_image_path)

# Save the new image as SVG
svg_image_path = final_image_path.replace('.png', '.svg')
svg_image = svgwrite.Drawing(filename=svg_image_path, size=(total_width, max_height))
x_offset = 0
y_offset = 0
for img_name, img in zip([img1_name, img2_name, img3_name, img4_name, img5_name], images):
    img_path = os.path.join(input_directory, img_name)
    with open(img_path, 'rb') as f:
        img_data = f.read()
        svg_image.add(svg_image.image(href=img_path, insert=(x_offset, y_offset), size=img.size))
    x_offset += img.size[0]
svg_image.save()
