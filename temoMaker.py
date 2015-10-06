from PIL import Image
from os import listdir
from os.path import isfile, join
from math import sqrt
from PyQt5.QtCore import *
from PyQt5.QtWidgets import *

class makeComposite:
    def __init__(self, dir):
        try:
            files = [f for f in listdir(dir) if isfile(join(dir, f))]

            sampleImage = Image.open(join(dir,files[0]))
            (imageW, imageH) = sampleImage.size

            totalPixels = imageW * imageH * len(files)

            side = (sqrt(totalPixels))

            if side / imageW - side // imageW < 1/2:
                resolutionH = side // imageW
            else:
                resolutionH = side // imageW + 1

            resolutionV = len(files) // resolutionH if len(files) / resolutionH - len(files) // resolutionH == 0 else len(files) // resolutionH + 1

            composite = Image.new("RGBA", (int(imageW*resolutionH), int(imageH*resolutionV)), (255, 0, 0, 0))

            for row in range(0, int(resolutionV)):
                for column in range(0, int(resolutionH)):
                    currentImageIndex = int(row*resolutionH + column)
                    if len(files)-1 >= currentImageIndex:
                        currentImage = Image.open(join(dir,files[currentImageIndex]))
                        composite.paste(currentImage, (int(column*imageW), int(row*imageH)))
            self.image = composite
        except:
            print ("Unexpected error:", sys.exc_info()[0])
            raise

class Form(QWidget):
    def __init__(self, parent=None):
        super(Form, self).__init__(parent)

        self.nameLabel = QLabel("Imager folder")

        self.folderLine = QLineEdit()
        self.openButton = QPushButton("Pick")
        self.generateButton = QPushButton("Generate")
        self.sizeLabel = QLabel("Image size")

        self.hLabel = QLabel("Height")
        self.wLabel = QLabel("Width")
        self.imageW = QLineEdit()
        self.imageH = QLineEdit()

        buttonLayout1 = QVBoxLayout()
        buttonLayout1.addWidget(self.nameLabel)
        buttonLayout1.addWidget(self.folderLine)

        buttonLayout2 = QVBoxLayout()
        buttonLayout2.addWidget(self.sizeLabel)

        buttonLayout3 = QHBoxLayout()
        buttonLayout3.addWidget(self.wLabel)
        buttonLayout3.addWidget(self.hLabel)

        buttonLayout4 = QHBoxLayout()
        buttonLayout4.addWidget(self.imageW)
        buttonLayout4.addWidget(self.imageH)

        buttonLayout5 = QHBoxLayout()
        buttonLayout5.addWidget(self.openButton)
        buttonLayout5.addWidget(self.generateButton)

        self.openButton.clicked.connect(self.pickFolder)
        self.generateButton.clicked.connect(self.generateComposite)
        self.imageH.editingFinished.connect(self.resizeH)
        self.imageW.editingFinished.connect(self.resizeW)

        mainLayout = QGridLayout()
        mainLayout.addLayout(buttonLayout1, 0, 1)
        mainLayout.addLayout(buttonLayout2, 1, 1)
        mainLayout.addLayout(buttonLayout3, 2, 1)
        mainLayout.addLayout(buttonLayout4, 3, 1)
        mainLayout.addLayout(buttonLayout5, 4, 1)

        self.setLayout(mainLayout)
        self.setWindowTitle("Select folder")

    def resizeH(self):
        self.changeResolution("H")

    def resizeW(self):
        self.changeResolution("W")

    def changeResolution(self, label):
        ratioWH = self.oW / self.oH
        ratioHW = self.oH / self.oW

        if label == "H":
            try:
                if self.imageH.text() != "":
                    newW = str(int(round(float(self.imageH.text()) * ratioWH)))
                    self.imageW.clear()
                    self.imageW.insert(newW)
            except:
                print (sys.exc_info())
        else:
            try:
                if self.imageW.text() != "":
                    newH = str(int(round(float(self.imageW.text()) * ratioHW)))
                    self.imageH.clear()
                    self.imageH.insert(newH)
            except:
                print (sys.exc_info())

    def pickFolder(self):
        folder = QFileDialog.getExistingDirectory(self, 'Open folder', '')
        self.folderLine.insert(folder)

        try:
            self.composite = makeComposite(folder).image
            (width, height) = self.composite.size

            self.oW = width
            self.oH = height

            self.imageH.clear()
            self.imageW.clear()

            self.imageW.insert(str(width))
            self.imageH.insert(str(height))
        except:
            print (sys.exc_info())
            raise

    def generateComposite(self):
        saveLocation = QFileDialog.getSaveFileName (self, "Save Image", "", "Image Files (*.png)")
        try:
            newW = int(self.imageW.text())
            newH = int(self.imageH.text())

            resized = self.composite.resize((newW, newH), Image.ANTIALIAS)

            if saveLocation[0] != "":
                resized.save(saveLocation[0], format="PNG", optimize="1")
                resized.close()
        except:
            print (sys.exc_info())
            raise

if __name__ == '__main__':
    import sys

    app = QApplication(sys.argv)

    screen = Form()
    screen.show()

    sys.exit(app.exec_())
