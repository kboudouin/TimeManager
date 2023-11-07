<script setup>
import router from "../router";

const back = () => {
  router.back();
};
</script>

<template>
  <div class="grid h-screen px-4 place-content-center">
    <div class="text-center">
      <h1 class="font-black text-gray-100 text-9xl">401</h1>

      <p class="text-2xl font-bold tracking-tight text-white-900 sm:text-4xl">
        Uh-oh!
      </p>

      <p class="mt-4 text-red-500">You can't be here!</p>

      <a
        @click="back"
        class="inline-block px-5 py-3 mt-6 text-sm font-medium text-white bg-indigo-600 rounded hover:bg-indigo-700 focus:outline-none focus:ring"
      >
        Go Back
      </a>
    </div>
  </div>
</template>
