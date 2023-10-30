<script setup>
import { ref, onMounted } from "vue";
import { useToast } from "vue-toast-notification";
onMounted(() => {
  const $toast = useToast();
  $toast.success("Welcome to admin dashboard");
});
</script>

<template></template>
