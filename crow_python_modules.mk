
CROW_PMODULES=$(CROW_DIR)/python_modules

DISTRIBUTION_COMPILE_COMMAND=@$(libmesh_LIBTOOL) --tag=CXX $(LIBTOOLFLAGS) --mode=compile --quiet \
          $(libmesh_CXX) $(libmesh_CPPFLAGS) $(libmesh_CXXFLAGS) -I$(CROW_LIB_INCLUDE_DIR) -I$(CROW_DIR)/include/distributions/ -I$(CROW_DIR)/include/utilities/  -MMD -MF $@.d -MT $@ -c $< -o $@

#include $(PETSC_DIR)/conf/variables
EXTRA_MODULE_LIBS= #$(BLASLAPACK_LIB)

$(CROW_DIR)/src/distributions/DistributionContainer.$(obj-suffix): $(CROW_DIR)/src/distributions/DistributionContainer.C
	$(DISTRIBUTION_COMPILE_COMMAND)

$(CROW_DIR)/src/distributions/distribution_1D.$(obj-suffix): $(CROW_DIR)/src/distributions/distribution_1D.C
	$(DISTRIBUTION_COMPILE_COMMAND)

$(CROW_DIR)/src/distributions/distribution.$(obj-suffix): $(CROW_DIR)/src/distributions/distribution.C
	$(DISTRIBUTION_COMPILE_COMMAND)

$(CROW_DIR)/src/distributions/distributionFunctions.$(obj-suffix): $(CROW_DIR)/src/distributions/distributionFunctions.C
	$(DISTRIBUTION_COMPILE_COMMAND)

$(CROW_DIR)/src/distributions/distribution_base_ND.$(obj-suffix): $(CROW_DIR)/src/distributions/distribution_base_ND.C
	$(DISTRIBUTION_COMPILE_COMMAND)

$(CROW_DIR)/src/utilities/ND_Interpolation_Functions.$(obj-suffix): $(CROW_DIR)/src/utilities/ND_Interpolation_Functions.C
	$(DISTRIBUTION_COMPILE_COMMAND)

$(CROW_DIR)/src/utilities/NDspline.$(obj-suffix): $(CROW_DIR)/src/utilities/NDspline.C
	$(DISTRIBUTION_COMPILE_COMMAND)

$(CROW_DIR)/src/utilities/microSphere.$(obj-suffix): $(CROW_DIR)/src/utilities/microSphere.C
	$(DISTRIBUTION_COMPILE_COMMAND)

$(CROW_DIR)/src/utilities/inverseDistanceWeigthing.$(obj-suffix): $(CROW_DIR)/src/utilities/inverseDistanceWeigthing.C
	$(DISTRIBUTION_COMPILE_COMMAND)

$(CROW_DIR)/src/utilities/MDreader.$(obj-suffix): $(CROW_DIR)/src/utilities/MDreader.C
	$(DISTRIBUTION_COMPILE_COMMAND)

$(CROW_DIR)/python_modules/_distribution1Dpy2.so : $(CROW_DIR)/python_modules/distribution1Dpy2.i \
                                                 $(CROW_DIR)/src/distributions/distribution_1D.$(obj-suffix) \
                                                 $(CROW_DIR)/src/distributions/DistributionContainer.$(obj-suffix) \
                                                 $(CROW_DIR)/src/distributions/distributionFunctions.$(obj-suffix) \
                                                 $(CROW_DIR)/src/distributions/distribution_base_ND.$(obj-suffix) \
                                                 $(CROW_DIR)/src/utilities/ND_Interpolation_Functions.$(obj-suffix) \
                                                 $(CROW_DIR)/src/utilities/NDspline.$(obj-suffix) \
                                                 $(CROW_DIR)/src/utilities/microSphere.$(obj-suffix) \
                                                 $(CROW_DIR)/src/utilities/inverseDistanceWeigthing.$(obj-suffix) \
                                                 $(CROW_DIR)/src/utilities/MDreader.$(obj-suffix) \
                                                 $(CROW_DIR)/src/distributions/distribution.$(obj-suffix)
# Swig
	swig -c++ -python  -I$(CROW_DIR)/include/distributions/ -I$(CROW_DIR)/include/utilities/ \
          $(CROW_PMODULES)/distribution1Dpy2.i
# Compile
	$(libmesh_LIBTOOL) --tag=CXX $(LIBTOOLFLAGS) --mode=compile \
	$(libmesh_CXX) $(libmesh_CPPFLAGS) $(PYTHON2_INCLUDE)\
         -I$(CROW_DIR)/include/distributions/ -I$(CROW_DIR)/include/utilities/ \
	 -c  $(CROW_PMODULES)/distribution1Dpy2_wrap.cxx -o $(CROW_DIR)/python_modules/distribution1Dpy2_wrap.lo
	$(libmesh_LIBTOOL) --tag=CXX $(LIBTOOLFLAGS) --mode=link \
	 $(libmesh_CXX) $(libmesh_CXXFLAGS) \
	-shared -o $(CROW_PMODULES)/libdistribution1Dpy2.la $(PYTHON2_LIB) $(CROW_PMODULES)/distribution1Dpy2_wrap.lo $(CROW_DIR)/src/distributions/distribution_1D.$(obj-suffix) $(CROW_DIR)/src/distributions/distributionFunctions.$(obj-suffix)  $(CROW_DIR)/src/distributions/distribution.$(obj-suffix) $(CROW_DIR)/src/distributions/DistributionContainer.$(obj-suffix) $(CROW_DIR)/src/distributions/distribution_base_ND.$(obj-suffix)  $(CROW_DIR)/src/utilities/ND_Interpolation_Functions.$(obj-suffix) $(CROW_DIR)/src/utilities/microSphere.$(obj-suffix) $(CROW_DIR)/src/utilities/NDspline.$(obj-suffix)  $(CROW_DIR)/src/utilities/inverseDistanceWeigthing.$(obj-suffix)  $(CROW_DIR)/src/utilities/MDreader.$(obj-suffix) -rpath $(CROW_PMODULES) $(EXTRA_MODULE_LIBS)
	$(libmesh_LIBTOOL) --tag=CXX $(LIBTOOLFLAGS) --mode=install install -c $(CROW_PMODULES)/libdistribution1Dpy2.la  $(CROW_PMODULES)/libdistribution1Dpy2.la
	rm -f $(CROW_PMODULES)/_distribution1Dpy2.so
	ln -s libdistribution1Dpy2.$(crow_shared_ext) $(CROW_PMODULES)/_distribution1Dpy2.so

$(CROW_DIR)/python_modules/_distribution1Dpy3.so : $(CROW_DIR)/python_modules/distribution1Dpy3.i \
                                                 $(CROW_DIR)/src/distributions/distribution_1D.$(obj-suffix) \
                                                 $(CROW_DIR)/src/distributions/DistributionContainer.$(obj-suffix) \
                                                 $(CROW_DIR)/src/distributions/distributionFunctions.$(obj-suffix) \
                                                 $(CROW_DIR)/src/distributions/distribution_base_ND.$(obj-suffix) \
                                                 $(CROW_DIR)/src/utilities/ND_Interpolation_Functions.$(obj-suffix) \
                                                 $(CROW_DIR)/src/utilities/NDspline.$(obj-suffix) \
                                                 $(CROW_DIR)/src/utilities/microSphere.$(obj-suffix) \
                                                 $(CROW_DIR)/src/utilities/inverseDistanceWeigthing.$(obj-suffix) \
                                                 $(CROW_DIR)/src/utilities/MDreader.$(obj-suffix) \
                                                 $(CROW_DIR)/src/distributions/distribution.$(obj-suffix)
# Swig
	swig -c++ -python -py3 -I$(CROW_DIR)/include/distributions/  -I$(CROW_DIR)/include/utilities/ \
          $(CROW_PMODULES)/distribution1Dpy3.i
# Compile
	$(libmesh_LIBTOOL) --tag=CXX $(LIBTOOLFLAGS) --mode=compile \
	$(libmesh_CXX) $(libmesh_CPPFLAGS) $(PYTHON_INCLUDE)\
         -I$(CROW_DIR)/include/distributions/ -I$(CROW_DIR)/include/utilities/ \
	 -c  $(CROW_PMODULES)/distribution1Dpy3_wrap.cxx -o $(CROW_DIR)/python_modules/distribution1Dpy3_wrap.lo
	$(libmesh_LIBTOOL) --tag=CXX $(LIBTOOLFLAGS) --mode=link \
	 $(libmesh_CXX) $(libmesh_CXXFLAGS) \
	-shared -o $(CROW_PMODULES)/libdistribution1Dpy3.la $(PYTHON_LIB) $(CROW_PMODULES)/distribution1Dpy3_wrap.lo $(CROW_DIR)/src/distributions/distribution_1D.$(obj-suffix) $(CROW_DIR)/src/distributions/distributionFunctions.$(obj-suffix)  $(CROW_DIR)/src/distributions/distribution.$(obj-suffix) $(CROW_DIR)/src/distributions/DistributionContainer.$(obj-suffix) $(CROW_DIR)/src/distributions/distribution_base_ND.$(obj-suffix)  $(CROW_DIR)/src/utilities/ND_Interpolation_Functions.$(obj-suffix) $(CROW_DIR)/src/utilities/microSphere.$(obj-suffix) $(CROW_DIR)/src/utilities/NDspline.$(obj-suffix)  $(CROW_DIR)/src/utilities/inverseDistanceWeigthing.$(obj-suffix)  $(CROW_DIR)/src/utilities/MDreader.$(obj-suffix) -rpath $(CROW_PMODULES) $(EXTRA_MODULE_LIBS)
	$(libmesh_LIBTOOL) --tag=CXX $(LIBTOOLFLAGS) --mode=install install -c $(CROW_PMODULES)/libdistribution1Dpy3.la  $(CROW_PMODULES)/libdistribution1Dpy3.la
	rm -f $(CROW_PMODULES)/_distribution1Dpy3.so
	ln -s libdistribution1Dpy3.$(crow_shared_ext) $(CROW_PMODULES)/_distribution1Dpy3.so

######## Swig-ing ND_Interpolation_only

NDINTERPOLATION_COMPILE_COMMAND=@$(libmesh_LIBTOOL) --tag=CXX $(LIBTOOLFLAGS) --mode=compile --quiet \
          $(libmesh_CXX) $(libmesh_CPPFLAGS) $(libmesh_CXXFLAGS) -I$(CROW_LIB_INCLUDE_DIR) -I$(CROW_DIR)/include/utilities/  -MMD -MF $@.d -MT $@ -c $< -o $@

#$(CROW_DIR)/src/utilities/ND_Interpolation_Functions.$(obj-suffix): $(CROW_DIR)/src/utilities/ND_Interpolation_Functions.C
#	$(NDINTERPOLATION_COMPILE_COMMAND)

#$(CROW_DIR)/src/utilities/NDspline.$(obj-suffix): $(CROW_DIR)/src/utilities/NDspline.C
#	$(NDINTERPOLATION_COMPILE_COMMAND)

#$(CROW_DIR)/src/utilities/inverseDistanceWeigthing.$(obj-suffix): $(CROW_DIR)/src/utilities/inverseDistanceWeigthing.C
#	$(NDINTERPOLATION_COMPILE_COMMAND)

#$(CROW_DIR)/src/utilities/MDreader.$(obj-suffix): $(CROW_DIR)/src/utilities/MDreader.C
#	$(NDINTERPOLATION_COMPILE_COMMAND)

$(CROW_DIR)/python_modules/_interpolationNDpy2.so : $(CROW_DIR)/python_modules/interpolationNDpy2.i \
                                                 $(CROW_DIR)/src/utilities/ND_Interpolation_Functions.$(obj-suffix) \
                                                 $(CROW_DIR)/src/utilities/NDspline.$(obj-suffix) \
                                                 $(CROW_DIR)/src/utilities/microSphere.$(obj-suffix) \
                                                 $(CROW_DIR)/src/utilities/inverseDistanceWeigthing.$(obj-suffix) \
                                                 $(CROW_DIR)/src/utilities/MDreader.$(obj-suffix)
# Swig
	swig -c++ -python  -I$(CROW_DIR)/include/utilities/  \
          $(CROW_PMODULES)/interpolationNDpy2.i
# Compile
	$(libmesh_LIBTOOL) --tag=CXX $(LIBTOOLFLAGS) --mode=compile \
	$(libmesh_CXX) $(libmesh_CPPFLAGS) $(PYTHON2_INCLUDE)\
         -I$(CROW_DIR)/include/utilities/ \
	 -c  $(CROW_PMODULES)/interpolationNDpy2_wrap.cxx -o $(CROW_DIR)/python_modules/interpolationNDpy2_wrap.lo
	$(libmesh_LIBTOOL) --tag=CXX $(LIBTOOLFLAGS) --mode=link \
	 $(libmesh_CXX) $(libmesh_CXXFLAGS) \
	-shared -o $(CROW_PMODULES)/libinterpolationNDpy2.la $(PYTHON2_LIB) $(CROW_PMODULES)/interpolationNDpy2_wrap.lo $(CROW_DIR)/src/utilities/ND_Interpolation_Functions.$(obj-suffix) $(CROW_DIR)/src/utilities/microSphere.$(obj-suffix) $(CROW_DIR)/src/utilities/NDspline.$(obj-suffix)  $(CROW_DIR)/src/utilities/inverseDistanceWeigthing.$(obj-suffix)  $(CROW_DIR)/src/utilities/MDreader.$(obj-suffix) -rpath $(CROW_PMODULES) $(EXTRA_MODULE_LIBS)
	$(libmesh_LIBTOOL) --tag=CXX $(LIBTOOLFLAGS) --mode=install install -c $(CROW_PMODULES)/libinterpolationNDpy2.la  $(CROW_PMODULES)/libinterpolationNDpy2.la
	rm -f $(CROW_PMODULES)/_interpolationNDpy2.so
	ln -s libinterpolationNDpy2.$(crow_shared_ext) $(CROW_PMODULES)/_interpolationNDpy2.so

$(CROW_DIR)/python_modules/_interpolationNDpy3.so : $(CROW_DIR)/python_modules/interpolationNDpy3.i \
                                                 $(CROW_DIR)/src/utilities/ND_Interpolation_Functions.$(obj-suffix) \
                                                 $(CROW_DIR)/src/utilities/NDspline.$(obj-suffix) \
                                                 $(CROW_DIR)/src/utilities/microSphere.$(obj-suffix) \
                                                 $(CROW_DIR)/src/utilities/inverseDistanceWeigthing.$(obj-suffix) \
                                                 $(CROW_DIR)/src/utilities/MDreader.$(obj-suffix)
# Swig
	swig -c++ -python -py3 -I$(CROW_DIR)/include/utilities/  \
          $(CROW_PMODULES)/interpolationNDpy3.i
# Compile
	$(libmesh_LIBTOOL) --tag=CXX $(LIBTOOLFLAGS) --mode=compile \
	$(libmesh_CXX) $(libmesh_CPPFLAGS) $(PYTHON_INCLUDE)\
         -I$(CROW_DIR)/include/utilities/ \
	 -c  $(CROW_PMODULES)/interpolationNDpy3_wrap.cxx -o $(CROW_DIR)/python_modules/interpolationNDpy3_wrap.lo
	$(libmesh_LIBTOOL) --tag=CXX $(LIBTOOLFLAGS) --mode=link \
	 $(libmesh_CXX) $(libmesh_CXXFLAGS) \
	-shared -o $(CROW_PMODULES)/libinterpolationNDpy3.la $(PYTHON_LIB) $(CROW_PMODULES)/interpolationNDpy3_wrap.lo $(CROW_DIR)/src/utilities/ND_Interpolation_Functions.$(obj-suffix) $(CROW_DIR)/src/utilities/microSphere.$(obj-suffix) $(CROW_DIR)/src/utilities/NDspline.$(obj-suffix)  $(CROW_DIR)/src/utilities/inverseDistanceWeigthing.$(obj-suffix)  $(CROW_DIR)/src/utilities/MDreader.$(obj-suffix) -rpath $(CROW_PMODULES) $(EXTRA_MODULE_LIBS)
	$(libmesh_LIBTOOL) --tag=CXX $(LIBTOOLFLAGS) --mode=install install -c $(CROW_PMODULES)/libinterpolationNDpy3.la  $(CROW_PMODULES)/libinterpolationNDpy3.la
	rm -f $(CROW_PMODULES)/_interpolationNDpy3.so
	ln -s libinterpolationNDpy3.$(crow_shared_ext) $(CROW_PMODULES)/_interpolationNDpy3.so



