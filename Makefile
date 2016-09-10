SCAD=openscad

SCAD_FILES=boardmount.scad bung.scad cabletubeholder.scad \
    camera-flash-plate.scad coffeemaker.scad din-power-outlet.scad  \
    fridge.scad handle.scad iphone4s-case.scad key.scad kicker.scad \
    knob.scad lampfoot.scad lawnmowerpart.scad mousering.scad       \
    osd-stick.scad peeler.scad peg.scad rummistand.scad             \
    sharpener.scad wallmount.scad wc.scad windowpart.scad

DEPS=$(patsubst %.scad,.%.d,$(SCAD_FILES))
TARGET=$(patsubst %.scad,STL/%.stl,$(SCAD_FILES))

all: ${TARGET}

STL/%.stl: %.scad
	$(SCAD) -m make -o $@ -d $(patsubst %.scad,.%.d,$<) $<

README.html: README.rst
	rst2html $< > $@

%-small.jpg: %.jpg
	djpeg $< | pnmscale .1 | cjpeg > $@

include $($(wildcard $(DEPS))

