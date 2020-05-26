I have given here my code which compress the image using Efficient Lossless 
Encoder.
full description of all these function are mentioned in the comments inside 
the code.
there is a main code named as main.m which is the building block for all these function.
main.m - creates the quantized image qnz.
bpp.m - after using main qnz value is taken as input for this function & it 
caluclates the value of bits per pixel of an image.
I also here give the compressed image of lena_color_512.tif in a form of binary format binaryimage.bin.