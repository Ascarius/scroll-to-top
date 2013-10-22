"use strict"

module.exports = (grunt) ->

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    coffee:
      compile:
        options:
          bare: true
        src: ['src/<%= pkg.name %>.coffee']
        dest: 'dist/<%= pkg.name %>.js'

    uglify:
      dist:
        options:
          compress: true
        src: ['<%= coffee.compile.dest %>']
        dest: 'dist/<%= pkg.name %>.min.js'

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  grunt.registerTask 'default', ['coffee', 'uglify']
