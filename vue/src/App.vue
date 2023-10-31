<script setup>
import Authentification from "./components/Authentification.vue";
import router from "./Router";
import { ref, onMounted } from "vue";
onMounted(() => {
  isUserConnected.value = localStorage.getItem("userId");
});

const isUserConnected = ref(localStorage.getItem("userId"));
</script>

<template>
  <Authentification />
  <div><router-view v-if="isUserConnected"></router-view></div>
</template>
