const { defineConfig } = require("vite");
const { svelte } = require("@sveltejs/vite-plugin-svelte");

module.exports = {
  plugins: [svelte()],
};
