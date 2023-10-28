<script setup>
import axios from "axios";
import { store } from "../store.js";

const editModal = () => {
  store.toggleEditModal();
};
// console.log(store.workingTime.id);
let start = "";
let end = "";

// MODIFIER UN TEMPS DE TRAVAIL
const editWorkingTime = async () => {
  try {
    await axios.put(
      // `http://localhost:4000/api/workingtimes/${store.workingTime.id}?start=${start}&end=${end}`
      `http://54.88.141.45:4000/api/workingtimes/${store.workingTime.id}?start=${start}&end=${end}`
    );
    window.location.reload();
  } catch (error) {
    console.log(error);
    alert("Une erreur est survenue lors de la modification de WorkingTime");
  }
};
</script>
<template>
  <section id="modal" @click="editModal"></section>
  <div class="overlay">
    <h1 style="text-align: center">Modifier un temps de travail</h1>
    <form @submit="(e) => e.preventDefault()">
      <label for="start-time">Date de debut</label>
      <input
        type="datetime-local"
        name="start-time"
        id="start-time"
        v-model="start" />
      <label for="end-time">Date de fin</label>
      <input
        type="datetime-local"
        name="end-time"
        id="end-time"
        v-model="end" />
      <button @click="editWorkingTime">Ajouter ce temps de travail</button>
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
