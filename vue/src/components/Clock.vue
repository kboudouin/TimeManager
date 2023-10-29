<script setup>
import { ref } from "vue";
import axios from "axios";
import { useToast } from "vue-toast-notification";
import "vue-toast-notification/dist/theme-sugar.css";

const status = ref(false);
const sTime = ref(null);
const eTime = ref(null);
const timer = ref("00:00:00");

const route = window.location.href;
const id = route.split("/").slice(-1)[0];
let interval;

const fetchData = async () => {
  const resp = await axios.get(`http://44.207.191.254:4000/api/clocks/${id}`);
  status.value = resp.data.clock.status;
  if (status.value) {
    sTime.value = resp.data.clock.time;
    startTimer(new Date(resp.data.clock.time));
  }
};

const startTimer = (startTime) => {
  clearInterval(interval);
  interval = setInterval(() => {
    const now = new Date();
    const diff = new Date(now - startTime);
    const hh = String(diff.getUTCHours()).padStart(2, "0");
    const mm = String(diff.getUTCMinutes()).padStart(2, "0");
    const ss = String(diff.getUTCSeconds()).padStart(2, "0");
    timer.value = `${hh}:${mm}:${ss}`;
  }, 1000);
};

//Start timer clock
const clock = async () => {
  await axios.post(`http://44.207.191.254:4000/api/clocks/${id}?status=true`);
  fetchData();
};

//End timer function
const refresh = async () => {
  const $toast = useToast();
  $toast.success("WorkingTime Successfully Created!");
  clearInterval(interval);
  timer.value = "00:00:00";
  eTime.value = new Date().toISOString();

  //Reset the users clock
  await axios.post(`http://44.207.191.254:4000/api/clocks/${id}?status=false`);

  //Create new workingtime
  await axios.post(
    `http://44.207.191.254:4000/api/workingtimes/${id}?start=${sTime.value}&end=${eTime.value}`
  );
  fetchData();
};

fetchData();
</script>

<template>
  <div class="p-4">
    <h1
      class="font-extrabold text-transparent sm:text-2xl md:text-7xl bg-clip-text bg-gradient-to-r to-emerald-600 from-sky-400 m-4"
    >
      The Clock
    </h1>
    <div class="p-4 sm:p-5 bg-white rounded-lg w-full">
      <div class="flex flex-col items-center pb-4 sm:pb-10">
        <div
          class="w-full bg-neutral-800 rounded-lg p-4 sm:p-6 mb-4 sm:mb-10 shadow"
        >
          <h5 class="text-4xl sm:text-6xl md:text-8xl font-bold text-white">
            {{ timer }}
          </h5>
        </div>
        <div class="flex mt-4 space-x-2 sm:space-x-3 md:mt-6">
          <a
            v-if="status"
            @click="refresh"
            class="inline-flex items-center px-3 sm:px-4 py-1 sm:py-2 text-sm font-medium bg-blue-700 text-white rounded-lg hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300"
          >
            Stop Shift
          </a>
          <a
            v-else
            @click="clock"
            class="inline-flex items-center px-3 sm:px-4 py-1 sm:py-2 text-sm font-medium text-gray-900 bg-white border border-gray-300 rounded-lg hover:bg-gray-100 focus:ring-4 focus:outline-none focus:ring-gray-200"
          >
            Start Shift
          </a>
        </div>
      </div>
    </div>
  </div>
</template>
