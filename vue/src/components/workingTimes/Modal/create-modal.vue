<script setup>
import axios from "axios";
import { store } from "../store.js";

const clickEvent = () => {
  return store.toggleCreateModal();
};
let start = "";
let end = "";

// CREER UN TEMPS DE TRAVAIL
const createWorkingTime = async () => {
  try {
    await axios.post(
      `http://54.88.141.45:4000/api/workingtimes/${localStorage.getItem(
        "userId"
      )}?start=${start}&end=${end}`
    );
    window.location.reload();
  } catch (error) {
    alert("Une erreur est survenue lors de la creation de WorkingTime");
  }
};
</script>
<template>
  <section id="modal" @click="clickEvent"></section>
  <div class="overlay">
    <h1 style="text-align: center">Creer un temps de travail</h1>
    <form @submit="(e) => e.preventDefault()">
      <label for="start-time">Date de debut</label>
      <input
        v-model="start"
        type="datetime-local"
        name="start-time"
        id="start-time" />
      <label for="end-time">Date de fin</label>
      <input
        v-model="end"
        type="datetime-local"
        name="end-time"
        id="end-time" />
      <button @click="createWorkingTime">Ajouter ce temps de travail</button>
    </form>
  </div>
</template>
<style scoped lang="scss">
#modal {
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.5) !important;
  position: absolute !important;
  top: 0;
  left: 0;
  z-index: 99 !important;
}
.overlay {
  padding: 1rem;
  width: 30rem;
  height: fit-content;
  background: #2b2b2b;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  border-radius: 5px;
  z-index: 100;
  display: grid;
  grid-template-rows: 10% 90%;
  grid-template-columns: 1fr;
  & h1 {
    // color: rgb(91, 91, 255);
    color: white;
    font-size: 1rem;
    text-transform: uppercase;
    font-weight: 900;
  }
  form {
    display: flex;
    flex-direction: column;
    width: 70%;
    height: 100%;
    margin: 1rem auto;
    label {
      margin: 1rem 0;
      color: white;
    }
    input {
      padding: 0.7rem;
    }
    button {
      margin: 1rem 0;
      color: white;
      background: #0088ff;
    }
  }
}
</style>
