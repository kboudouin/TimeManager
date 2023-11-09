<script setup>
import { ref, onMounted, watch } from "vue";
import { defineProps } from "vue";
import { Bar } from "vue-chartjs";
import { useRoute } from "vue-router";
import router from "../router";
import axios from "axios";
import Clock from "./Clock.vue";
import wtRender from "./workingTimes/wtRender.vue";
import "chart.js/auto";

const dailyData = ref(null);
const username = ref(localStorage.getItem("userUsername"));
const dateFilter = ref({ start: "2023-01-01", end: "2023-12-31" });
const loading = ref(true);

const fetchData = async () => {
  loading.value = true;
  let id = localStorage.getItem("userId");
  const token = localStorage.getItem("token");
  const resp = await axios.get(
    `https://epitechproject.com/api/workingtimes/${id}?start=${dateFilter.value.start}T00:00:00Z&end=${dateFilter.value.end}T00:00:00Z`,
    {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    }
  );
  const workByDay = {};

  if (resp.data.error) {
    router.replace("/error");
    return;
  }

  if (resp.data && resp.data.workingtimes) {
    // Process the fetched data
    resp.data.workingtimes.forEach((wt) => {
      const day = getDayString(wt.start);
      const startHour = new Date(wt.start).getHours();
      const endHour = new Date(wt.end).getHours();
      const workHours = endHour - startHour;
      workByDay[day] = (workByDay[day] || 0) + workHours;
    });

    // Prepare the daily data
    dailyData.value = {
      labels: Object.keys(workByDay),
      datasets: [
        {
          label: "Daily Working Hours",
          data: Object.values(workByDay),
          backgroundColor: "#ed574c",
        },
      ],
    };
  }

  loading.value = false;
};

onMounted(fetchData);

const getDayString = (dateString) => {
  const date = new Date(dateString);
  return `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`;
};
</script>

<template>
  <div v-if="loading">
    <div class="text-center mt-64 z-0">
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
    <div className="flex justify-between ml-12" style="margin-bottom: -50px">
      <h1 className="text-4xl font-bold ">Welcome back {{ username }} 👋</h1>
    </div>

    <div
      class="scale-95 grid md:grid-cols-2 sm:grid-cols-1 gap-6 grid-rows-3 p-12"
    >
      <!-- Clock -->
      <div class="bg-base-200 rounded-lg transition-shadow hover:shadow-xl">
        <Clock style="max-height: 320px; overflow-y: auto"></Clock>
      </div>

      <!-- Dashboard -->
      <div
        class="bg-base-200 rounded-lg transition-shadow hover:shadow-xl p-4"
        style="max-height: 320px; overflow-y: auto"
      >
        <h1 className="text-4xl font-extrabold ">This is dashboard 🖥️</h1>
        <h1 className="text-3xl font-bold ">This is dashboard 🖥️</h1>
        <h1 className="text-2xl font-bold ">This is dashboard 🖥️</h1>
        <h1 className="text-xl font-bold ">This is dashboard 🖥️</h1>
        <h1 className="text-lg font-bold ">This is dashboard 🖥️</h1>
        <h1 className="text-base font-bold ">This is dashboard 🖥️</h1>
        <h1 className="text-sm font-bold ">This is dashboard 🖥️</h1>
        <h1 className="text-xs font-bold ">This is dashboard 🖥️</h1>
      </div>

      <!-- Daily Chart -->
      <div
        class="bg-base-200 p-4 rounded-lg transition-shadow hover:shadow-xl"
        v-if="dailyData"
      >
        <Bar id="Daily-Bar-Chart" :data="dailyData" />
      </div>

      <!-- Workingtimes -->
      <div
        class="bg-base-200 rounded-lg transition-shadow hover:shadow-xl p-4"
        style="max-height: 320px; overflow-y: auto"
      >
        <wtRender></wtRender>
      </div>
    </div>
  </div>
</template>
