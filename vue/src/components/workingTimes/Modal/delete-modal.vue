<script setup>
import axios from "axios";
import { store } from "../store.js";
import VueCookies from "vue-cookies";

const deleteModal = () => {
  // console.log(store.workingTime);
  return store.toggleDeleteModal();
};

const deleteEvent = async () => {
  try {
    const token = localStorage.getItem("token");
    await axios.delete(
      `https://epitechproject.com/api/workingtimes/${store.workingTime.id}`,
      {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      }
    );
    store.toggleDeleteModal();
    window.location.reload();
  } catch (error) {
    alert(
      "Une erreur est survenue lors de la suppression de WorkingTime" +
        store.workingTimeData.id
    );
  }
};
</script>
<template>
  <section id="modal" @click="deleteModal"></section>
  <div class="overlay">
    <h1 style="text-align: center">Suppression</h1>
    <p>
      Lorem ipsum dolor sit amet consectetur adipisicing elit. Deserunt amet
      illum repudiandae
    </p>
    <button @click="deleteEvent">Supprimer</button>
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
  width: 20rem;
  height: fit-content;
  background: #2b2b2b;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  border-radius: 5px;
  z-index: 100;
  & h1 {
    color: white;
    font-size: 1rem;
    text-transform: uppercase;
    font-weight: 900;
  }
  p {
    color: white;
    margin: 1rem 0;
  }
  button {
    background: red;
    color: white;
    width: 100%;
  }
}
</style>
