<script setup>
import { ref } from "vue";
import { useToast } from "vue-toast-notification";
import axios from "axios";
import { defineEmits } from "vue";

const emit = defineEmits(["close", "fetchData"]);
const manager = ref(null);
const members = ref([]);
const allUsers = ref([]);
const managers = ref([]);
const users = ref([]);

// Fetch all users and filter out managers
const getAllUsers = async () => {
  try {
    const token = localStorage.getItem("token");
    const resp = await axios.get(`https://epitechproject.com/api/users/`, {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    });

    allUsers.value = resp.data.users;
    console.log(resp.data.users);
    managers.value = allUsers.value.filter((user) => user.role === "manager");
    users.value = allUsers.value.filter((user) => user.role === "employee");
  } catch (error) {
    useToast().error("Error fetching users");
    console.error(error);
  }
};

// Get users on component mount
getAllUsers();

// Create team function including selected manager and members
const createTeam = async () => {
  try {
    const token = localStorage.getItem("token");

    const selectedManager = managers.value.find(
      (mgr) => mgr.id === manager.value
    );
    const teamMembers = members.value.map((member) => ({
      userid: member.id.toString(),
      user: member.username,
    }));

    const teamData = {
      leaderId: selectedManager.id,
      leader: selectedManager.username,
      members: teamMembers,
    };

    await axios.post(`https://epitechproject.com/api/teams`, teamData, {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    });

    emit("close");
    emit("fetchData");
    useToast().success("Team created successfully");
  } catch (error) {
    useToast().error("Error creating team");
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
            Create New Team
          </h3>
          <form class="space-y-6" @submit.prevent="createTeam">
            <div>
              <label
                for="manager"
                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
                >Choose Manager</label
              >
              <select
                v-model="manager"
                id="manager"
                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white"
              >
                <option value="" disabled>Select a manager</option>
                <option
                  v-for="manager in managers"
                  :key="manager.id"
                  :value="manager.id"
                >
                  {{ manager.username }}
                </option>
              </select>
            </div>
            <div>
              <label
                for="members"
                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
                >Members</label
              >
              <select
                v-model="members"
                id="members"
                multiple
                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white"
              >
                <option v-for="user in users" :key="user.id" :value="user">
                  <span
                    class="bg-blue-100 text-blue-800 text-xs font-medium mr-2 px-2.5 py-0.5 rounded-full dark:bg-blue-900 dark:text-blue-300"
                    >{{ user.username }}</span
                  >
                </option>
              </select>
            </div>
            <button
              type="submit"
              class="w-full text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
            >
              Create Team
            </button>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>
