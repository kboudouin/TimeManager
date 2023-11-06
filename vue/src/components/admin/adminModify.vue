<script setup>
import { ref, watch } from "vue";
import { useToast } from "vue-toast-notification";
import axios from "axios";
import { defineProps, defineEmits } from "vue";
import VueCookies from "vue-cookies";

const { user } = defineProps(["user"]);
const emit = defineEmits(["close", "fetchData"]);

const username = ref(user.username);
const id = ref(user.id);
const email = ref(user.email);
const role = ref(user.role);

watch(user, (newValue) => {
  username.value = newValue.username;
  email.value = newValue.email;
  role.value = newValue.role;
});

const modifyUser = async () => {
  try {
    const token = VueCookies.get("token");
    await axios.put(
      `https://epitechproject.com/api/users/${id.value}?email=${email.value}&username=${username.value}&role=${role.value}`,
      {},
      {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      }
    );
    emit("close");
    await emit("fetchData");
    const $toast = useToast();
    $toast.success("User updated successfully");
  } catch (error) {
    const $toast = useToast();
    $toast.error("Error updating user");
    console.error(error);
  }
};
</script>

<template>
  <div
    tabindex="-1"
    aria-hidden="true"
    class="fixed top-0 left-0 flex justify-center z-50 w-full p-4 overflow-x-hidden overflow-y-auto md:inset-0 h-[calc(100%-1rem)] max-h-full"
  >
    <div class="relative w-full max-w-md max-h-full">
      <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
        <button
          type="button"
          @click="emit('close')"
          class="btn btn-primary absolute top-3 right-2.5 rounded-lg text-sm w-14 h-6 ml-auto inline-flex justify-center items-center"
          data-modal-hide="authentication-modal"
        >
          Close
        </button>
        <div class="px-6 py-6 lg:px-8">
          <h3 class="mb-4 text-xl font-medium text-gray-900 dark:text-white">
            Updating {{ user.username }}
          </h3>
          <form class="space-y-6" action="#" @submit.prevent="modifyUser">
            <div>
              <label
                for="username"
                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
                >Username</label
              >
              <input
                v-model="username"
                id="username"
                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white"
              />
            </div>
            <div>
              <label
                for="email"
                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
                >Email</label
              >
              <input
                v-model="email"
                id="email"
                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white"
              />
            </div>
            <div>
              <label
                for="role"
                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
                >Role</label
              >
              <select
                v-model="role"
                id="role"
                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:text-white"
              >
                <option value="employee">Employee</option>
                <option value="manager">Manager</option>
                <option value="admin">Admin</option>
              </select>
            </div>
            <button
              type="submit"
              class="w-full text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
            >
              Update
            </button>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>
