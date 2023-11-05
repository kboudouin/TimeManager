<script setup>
import { ref, onMounted } from "vue";
import { useRoute } from "vue-router";
import { useToast } from "vue-toast-notification";
import router from "../router";
import axios from "axios";
import VueCookies from "vue-cookies";

const status = ref(false);
const sTime = ref(null);
const eTime = ref(null);
const timer = ref("00:00:00");
const loading = ref(false);

const onVacation = ref(false);
const onSickLeave = ref(false);

const route = useRoute();
const id = route.params.id;

if (
  localStorage.getItem("userId") !== id &&
  localStorage.getItem("userId") !== "admin"
) {
  router.replace("/error");
}

let interval;

// Function to get all data
const fetchData = async () => {
  loading.value = true;
  const $toast = useToast();
  try {
    const token = VueCookies.get("token");
    const resp = await axios.get(
      `http://44.207.191.254:4000/api/clocks/${id}`,
      {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      }
    );
    if (resp.data.error) {
      router.replace("/error");
    }
    status.value = resp.data.clock.status;
    sTime.value = resp.data.clock.time;
    if (status.value) {
      startTimer(new Date(sTime.value));
      loading.value = false;
    }
  } catch (error) {}
};

// Function to start the time by looking at last time in data
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

// Function to start the clock
const clock = async () => {
  const $toast = useToast();
  status.value = true;
  sTime.value = new Date().toISOString();
  startTimer(new Date(sTime.value));

  try {
    const token = VueCookies.get("token");
    await axios.post(
      `http://44.207.191.254:4000/api/clocks/${id}?status=true`,
      {},
      {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      }
    );
  } catch (error) {
    $toast.error("An error has been encountered!");
    status.value = false;
    clearInterval(interval);
  }
};

// Function to start refrsh clock + Create workingtime
const refresh = async () => {
  const $toast = useToast();
  status.value = false;
  eTime.value = new Date().toISOString();
  clearInterval(interval);
  timer.value = "00:00:00";
  $toast.success("WorkingTime Successfully Created!");
  const token = VueCookies.get("token");
  const clockRequest = axios.post(
    `http://44.207.191.254:4000/api/clocks/${id}?status=false`,
    {},
    {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    }
  );
  const workingTimeRequest = axios.post(
    `http://44.207.191.254:4000/api/workingtimes/${id}?start=${sTime.value}&end=${eTime.value}`,
    {},
    {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    }
  );

  try {
    await Promise.all([clockRequest, workingTimeRequest]);
  } catch (error) {
    $toast.error("An error has been encountered!");
  }
};

// Retrieve onVacation and onSickLeave values from local storage on page load
onMounted(() => {
  fetchData();

  if (localStorage.getItem("onVacation") === "true") {
    onVacation.value = true;
  }
  if (localStorage.getItem("onSickLeave") === "true") {
    onSickLeave.value = true;
  }
});

// Update local storage when onVacation or onSickLeave values change
const updateLocalStorage = () => {
  localStorage.setItem("onVacation", onVacation.value);
  localStorage.setItem("onSickLeave", onSickLeave.value);
};

// Toggle the value of onVacation and log the updated value
const logVacationStatus = () => {
  onVacation.value = !onVacation.value;
  updateLocalStorage();
};

// Toggle the value of onSickLeave and log the updated value
const logSickLeaveStatus = () => {
  onSickLeave.value = !onSickLeave.value;
  updateLocalStorage();
};
</script>

<template>
  <div>
    <h1
      class="mb-4 text-3xl font-extrabold text-gray-900 dark:text-white md:text-5xl lg:text-6xl"
    >
      <span
        class="text-transparent bg-clip-text bg-gradient-to-r to-emerald-600 from-sky-400"
        >The Clock</span
      >
    </h1>
    <div class="w-full p-5 bg-white rounded-lg">
      <div class="flex flex-col items-center pb-10">
        <div class="w-full shadow bg-neutral-800 rounded-lg p-6 mb-10">
          <div v-if="onVacation && !onSickLeave">
            <h5 class="text-5xl font-bold text-gray-900 dark:text-white">
              ON VACATION
            </h5>
          </div>
          <div v-if="onSickLeave && !onVacation">
            <h5 class="text-5xl font-bold text-gray-900 dark:text-white">
              ON SICK DAY
            </h5>
          </div>
          <h5
            v-if="!onVacation && !onSickLeave"
            class="text-4xl sm:text-6xl md:text-8xl font-bold text-white"
          >
            <div v-if="!loading">{{ timer }}</div>
            <div v-if="loading" class="flex flex-col items-center">
              <svg
                aria-hidden="true"
                class="w-16 h-16 text-gray-200 animate-spin dark:text-gray-600 fill-blue-600"
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
          </h5>
          <h3
            v-if="onVacation && onSickLeave"
            class="text-4xl font-bold text-gray-900 dark:text-white"
          >
            Choose only one parameter
          </h3>
        </div>

        <div v-if="!loading" class="flex justify-start">
          <div
            id="app"
            class="w-full shadow bg-neutral-800 rounded-lg p-6 mb-10"
          >
            <div>
              <input
                type="checkbox"
                class="toggle toggle-warning"
                v-model="onVacation"
                @click="logVacationStatus"
              />
              On vacation
            </div>
            <div>
              <input
                type="checkbox"
                class="toggle toggle-info"
                v-model="onSickLeave"
                @click="logSickLeaveStatus"
              />
              On sick leave
            </div>
          </div>
        </div>

        <div v-if="!onVacation && !onSickLeave">
          <div v-if="!loading" class="flex mt-4 space-x-3 md:mt-6">
            <a
              v-if="status"
              @click="refresh"
              class="scale-150 inline-flex items-center px-4 py-2 text-sm font-medium text-center text-white bg-blue-700 rounded-lg hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
              >Stop Shift</a
            >
            <a
              v-else
              @click="clock"
              class="scale-150 inline-flex items-center px-4 py-2 text-sm font-medium text-center text-gray-900 bg-white border border-gray-300 rounded-lg hover:bg-gray-100 focus:ring-4 focus:outline-none focus:ring-gray-200 dark:bg-gray-800 dark:text-white dark:border-gray-600 dark:hover:bg-gray-700 dark:hover:border-gray-700 dark:focus:ring-gray-700"
              >Start Shift</a
            >
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
