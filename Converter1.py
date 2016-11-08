# -*- coding: utf-8 -*-
from PIL import Image
 
def rgb565(r,g,b):
    ##nR = int(round(r/255.0*31.0))
    ##nG = int(round(g/255.0*63.0))
    ##nB = int(round(b/255.0*31.0))
    nR = int(round((r*7.0)/255.0))
    nG = int(round((g*7.0)/255.0))
    nB = int(round((b*3.0)/255.0))
    return (nR<<5)+(nB<<3)+nG
 
name = 'TodoNA' #Poner aca el nombre que se quiere para archivo de matriz
path_imagen = 'C:\\Users\\usuario\\Pictures\\20140414\\proyecto\\TTnoAdecuada.jpg' #Direccion de imagen
 
img = Image.open(path_imagen)
pix = img.load()
output = '\n'
output += '.section .data'+'\n'
output += '.align 1'+'\n'+'\n'
output += '.globl '+name+'Height'+'\n'
output += ''+name+'Height: .hword '+str(img.size[1])+'\n'
output += '.globl '+name+'Width'+'\n'
output += ''+name+'Width: .hword '+str(img.size[0])+'\n'
output += '.globl '+name+'\n'+'\n'
output += ''+name+':\n'
 
for j in range(img.size[1]):
    list_ = []
    for i in range(img.size[0]):
        if len(pix[i,j])==3:
            r,g,b = pix[i,j]
        elif len(pix[i,j])==4:
            r,g,b,a = pix[i,j]
        else:
            print "Error"
            break
        newRGB = rgb565(r,g,b) # convert to 8 bits
        list_.append(newRGB)
    output += '    .hword '+', '.join([str(a) for a in list_])+'\n'
 
# save the file
open(name+'.s','w').write(output)
