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

        nameLabel = QLabel("Imager folder")
        self.folderLine = QLineEdit()
        self.openButton = QPushButton("Pick")
        self.generateButton = QPushButton("Generate")

        buttonLayout2 = QHBoxLayout()
        buttonLayout2.addWidget(self.openButton)

        buttonLayout1 = QVBoxLayout()
        buttonLayout1.addWidget(nameLabel)
        buttonLayout1.addWidget(self.folderLine)

        self.openButton.clicked.connect(self.pickFolder)

        mainLayout = QGridLayout()
        mainLayout.addLayout(buttonLayout1, 0, 1)
        mainLayout.addLayout(buttonLayout2, 1, 1)

        self.setLayout(mainLayout)
        self.setWindowTitle("Select folder")

    def pickFolder(self):
        folder = QFileDialog.getExistingDirectory(self, 'Open folder', '')
        self.folderLine.insert(folder)
        self.generateComposite()

    def generateComposite(self):
        folder = self.folderLine.text()
        saveLocation = QFileDialog.getSaveFileName (self, "Save Image", "", "Image Files (*.png)")

        try:
            composite = makeComposite(folder).image
            composite.save(saveLocation[0], format="PNG", optimize="1")
            composite.close()
        except:
            raise

if __name__ == '__main__':
    import sys

    app = QApplication(sys.argv)

    screen = Form()
    screen.show()

    sys.exit(app.exec_())
