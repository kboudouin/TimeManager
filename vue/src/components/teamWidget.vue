<script setup>
import { ref, onMounted, watch } from "vue";
import { defineProps } from "vue";
import { useRoute } from "vue-router";
import router from "../router";
import axios from "axios";

const loading = ref(true);
const myteams = ref(null);

const fetchData = async () => {
  loading.value = true;
  let userId = localStorage.getItem("userId");
  const token = localStorage.getItem("token");
  const resp = await axios.get(`https://epitechproject.com/api/teams`, {
    headers: {
      Authorization: `Bearer ${token}`,
    },
  });

  if (resp.data.error) {
    router.replace("/error");
    return;
  }

  if (resp.data.teams) {
    myteams.value = resp.data.teams;
    // Filter teams where the current user is either the leader or a member
    myteams.value = resp.data.teams.filter(
      (team) =>
        team.leaderId.toString() === userId ||
        team.members.some((member) => member.userid === userId)
    );
    console.log(myteams.value);
  }

  loading.value = false;
};

onMounted(fetchData);
</script>

<template>
  <div v-if="loading">
    <div class="text-center mt-12 z-0">
      <div role="status">
        <svg
          aria-hidden="true"
          class="inline w-32 h-32 mr-42 text-gray-200 animate-spin dark:text-gray-600 fill-blue-600"
          viewBox="0 0 100 101"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <path
            d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z"
            fill="currentColor"
          />
          <path
            d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z"
            fill="currentFill"
          />
        </svg>
        <span class="sr-only">Loading...</span>
      </div>
    </div>
  </div>
  <div v-if="!loading">
    <div class="">
      <div class="mb-4">
        <span class="text-xl">My Teams 👥</span>
      </div>
      <h1 v-if="myteams.length === 0" className="text-4xl font-extrabold ">
        You have no teams 🚫
      </h1>
      <div
        v-for="myteam in myteams"
        class="bg-base-100 p-6 shadow-xl rounded-xl mb-4"
      >
        <div class="mb-5">
          <span
            class="bg-yellow-100 text-yellow-800 text-sm font-medium px-2.5 py-0.5 rounded dark:bg-yellow-900 dark:text-yellow-300"
            >{{ myteam.leader }}
          </span>
        </div>
        <div
          class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-4"
        >
          <span
            v-for="member in myteam.members"
            class="bg-blue-100 text-blue-800 text-sm font-medium px-2.5 py-0.5 rounded dark:bg-blue-900 dark:text-blue-300"
          >
            {{ member.user }}
          </span>
        </div>
      </div>
    </div>
  </div>
</template>
