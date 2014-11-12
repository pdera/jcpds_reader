pro cake,oadetector,wv
	capture_calibration, oadetector, wv
    npointst=800
    npointsc=300
    Int=oimage->calculate_cake(oadetector, npointst,npointsc,[double(0),double(30)], [double(-180.),double(180.)])
    oimage->replace_image,congrid(Int[*,*], arr1,arr2)
    plot_image, oimage
end