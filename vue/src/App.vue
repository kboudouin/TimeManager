<script setup>
import Authentification from "./components/Authentification.vue";
import NavBar from "./components/navBar.vue";
import router from "./router";
import VueCookies from "vue-cookies";
import { ref, onMounted } from "vue";

const isUserConnected = ref(VueCookies.get("token"));

const handleUserConnected = () => {
  isUserConnected.value = VueCookies.get("token");
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
