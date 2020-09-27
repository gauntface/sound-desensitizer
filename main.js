#!/usr/bin/env node
'use strict';
const path = require('path');
const meow = require('meow');
const spawn = require('child_process').spawnSync;

const cli = meow(`
	Usage
	  $ node main.js --mp3="example.mp3"

	Options
    --mp3           The mp3 file to play
    --max_timeout   The max number of seconds to wait play sound
`, {
	flags: {
		mp3: {
			type: 'string',
			isRequired: true,
    },
    maxTimeout: {
      type: 'number',
    },
	}
});

async function run() {
  const secs = randomSecs(cli.flags.maxTimeout);

  console.log(`⏳ Waiting ${secs} seconds.`);
  await sleep(secs);
  console.log(`⌛ Done waiting.`);

  console.log(`🔊 Playing '${cli.flags.mp3}'`);
  await playmp3(cli.flags.mp3);
  console.log(`🔉 Done playing sound.`);
}

function randomSecs(max) {
  return Math.floor(Math.random() * max);
}

function sleep(secs) {
  return new Promise(resolve => {
    setTimeout(resolve, secs * 1000);
  })
}

async function playmp3(file) {
  const cmd = 'ffplay';
  const args = [
    '-nodisp',
    '-autoexit',
    file,
  ];
  spawn(cmd, args);
}

if (!cli.flags.maxTimeout) {
  cli.flags.maxTimeout = 60 * 60;
}

if (!path.isAbsolute(cli.flags.mp3)) {
  cli.flags.mp3 = path.join(__dirname, cli.flags.mp3);
}

run();