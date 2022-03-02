# MRuby + Gosu

This is a fork of MRuby which is capable of running [Gosu](https://github.com/gosu/gosu) games, by
statically linking against it through the [mruby-gosu](https://github.com/cyberarm/mruby-gosu)
wrapper.

Thank you to [Ruby2D](https://github.com/ruby2d/ruby2d) for the baseline MRuby Emscripten build
config!

## Building

This is a bit complicated right now - sorry!

You will need the Emscripten SDK (specifically `emcc`).

### Step 1. Setup

Check out this repository and [my fork of Gosu](https://github.com/AaronC81/gosu) in the same
parent directory - that is, you should have `mruby` and `gosu` directories in the same directory:

```
src
|--- gosu
|    |--- ...
|    '--- emscripten-build
'--- mruby
     |--- ...
     '--- wasm_config.rb
```

### Step 2. Build Gosu

cd into `gosu` and run the following to build the forked Gosu library:

```
./emscripten-build
```

When successful, it should drop a load of `.o` files into `emscripten-output`. Congratulations,
you've compiled Gosu for the web!

## Step 3. Build MRuby

cd back out of `gosu` and into `mruby`.

We need to use a slightly modified copy of the [mruby-gosu](https://github.com/cyberarm/mruby-gosu)
wrapper. cd into `mrbgems`, check it out with `git clone https://github.com/cyberarm/mruby-gosu`,
then cd into `mruby-gosu` and modify `mrbgem.rake` to remove the line:

```ruby
linker.libraries << "gosu-ffi"
```

(This is because `mruby-gosu` expects Gosu installed as a system library, but we are going to
manually link the object files into MRuby. This process should probably be automated in future!)

Now we're ready to build MRuby. cd back to just inside `mruby`, and run:

```
MRUBY_CONFIG=wasm_config.rb rake
```

If all goes well, you should get a `build/emscripten/lib/libmruby.a` binary.

## Step 4. Build Your Game

To get an actual web page, we need to do one more build where we link everything together and 
provide a `main` implementation which starts the Ruby interpreter.

An example of how to do this is provided in the `gosu-sample` directory of this (MRuby) repository.
To build it, cd into it and run `./build.sh`.

When that's done, you should get an `index.html` generated! WebAssembly won't just work if you open
this file in a browser - you need to host a local web server instead. If you have Python, you
can run `python -m http.server` in the `gosu-sample` directory to do this, and then navigate to
`localhost:8000` in your browser. Hooray - you are seeing a Gosu game in your browser (hopefully)!

If you'd like to change the Ruby code which runs, you can modify `gosu-sample/assets/main.rb`.
Please note that Ruby exceptions do not currently work properly, and will appear to hang/crash the
interpreter instead! You may find it useful to wrap the body of every function in a `begin/rescue`
which prints the exception if this appears to be happening.
