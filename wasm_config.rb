MRuby::CrossBuild.new('emscripten') do |conf|
  toolchain :clang

  conf.gembox "default"

  conf.cc.command = 'emcc'
  conf.cc.flags = ['-Os', '-Dbool=int', '-DMRB_INT64'] #, '-m64', '-sMEMORY64=1']
  conf.linker.command = 'emcc'
  conf.archiver.command = 'emar'

  # You need a checkout of github.com/AaronC81/gosu in the same directory as this mruby checkout.
  # You also need to build it before building this!
  conf.cc.include_paths << "../gosu/ffi"
  conf.linker.flags << "../gosu/emscripten-output/**/*.o ../gosu/emscripten-output/utf8proc.o"
  conf.linker.flags << "-sUSE_SDL=2"
  conf.linker.flags << "-sLEGACY_GL_EMULATION=1"

  # To grab this:
  #   1. cd mrbgems
  #   2. git clone https://github.com/cyberarm/mruby-gosu
  #   3. In the checked-out mrbgem.rake, remove this line: linker.libraries << "gosu-ffi"
  # Both checked out into mrbgems (cyberarm/ and mattn/ respectively)
  conf.gem core: "mruby-gosu"
end
