<script setup>
import Authentification from "./components/Authentification.vue";
import NavBar from "./components/navBar.vue";
import router from "./router";
import { ref, onMounted } from "vue";

const isUserConnected = ref(localStorage.getItem("userId"));

const handleUserConnected = () => {
  isUserConnected.value = localStorage.getItem("userId");
};

onMounted(() => {
  handleUserConnected();
});
</script>

<template>
  <Authentification
    @userConnected="handleUserConnected"
    v-if="!isUserConnected"
  />
  <div v-if="isUserConnected">
    <NavBar @userConnected="handleUserConnected" />
    <router-view></router-view>
  </div>
</template>
