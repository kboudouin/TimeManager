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
  <div
    tabindex="-1"
    style="z-index: 70"
    aria-hidden="true"
    class="fixed top-0 left-0 flex justify-center z-50 w-full p-4 overflow-x-hidden overflow-y-auto md:inset-0 h-[calc(100%-1rem)] max-h-full">
    <div class="relative w-full max-w-md max-h-full">
      <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
        <button
          type="button"
          @click="deleteModal"
          class="btn btn-primary absolute top-3 right-2.5 rounded-lg text-sm w-14 h-6 ml-auto inline-flex justify-center items-center"
          data-modal-hide="authentication-modal">
          Close
        </button>
        <div class="px-6 py-6 lg:px-8">
          <h3 class="mb-4 text-xl font-medium text-gray-900 dark:text-white">
            Delete this working time
          </h3>
          <div v-if="loading" class="flex flex-col items-center">
            <svg
              aria-hidden="true"
              class="w-16 h-16 text-gray-200 animate-spin dark:text-gray-600 fill-blue-600"
              viewBox="0 0 100 101"
              fill="none"
              xmlns="http://www.w3.org/2000/svg">
              <path
                d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z"
                fill="currentColor" />
              <path
                d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z"
                fill="currentFill" />
            </svg>
            <span class="sr-only">Loading...</span>
          </div>
          <p>
            Are you sure you want to cancel this working time? it will no longer
            be possible to reclaim it.
          </p>
          <button
            type="submit"
            class="w-full text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
            @click="deleteEvent">
            Delete working time
          </button>
        </div>
      </div>
    </div>
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
  z-index: 60 !important;
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
}
p {
  color: white;
  margin: 1rem 0;
}
button:last-child {
  background: red;
  color: white;
  width: 100%;
}
</style>
