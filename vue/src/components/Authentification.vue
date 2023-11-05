<script setup>
import { ref, onMounted } from "vue";
import axios from "axios";
import { useRouter, useRoute } from "vue-router";
import { useToast } from "vue-toast-notification";
import "vue-toast-notification/dist/theme-sugar.css";
import VueCookies from "vue-cookies";
import router from "../router";

const showSideNav = ref(false);
const isAdmin = ref(false);

const checkAdmin = () => {
  isAdmin.value = localStorage.getItem("role") === "admin";
};

const toggleSideNav = () => {
  showSideNav.value = !showSideNav.value;
};

onMounted(checkAdmin);
</script>

<template>
  <!-- IF USER CONNECTED -->
  <!-- MENU -->
  <div class="" v-if="isUserConnected">
    <button
      class="p-4 m-2 bg-blue-800"
      @click="toggleSideNav"
      style="position: fixed; z-index: 100; top: 0px; left: 0px"
    >
      ☰
    </button>

    <div
      class="flex flex-col flex-auto flex-shrink-0 antialiased bg-gray-50 text-gray-800 md:block z-50"
      v-show="showSideNav"
    >
      <div
        class="fixed flex flex-col top-0 left-0 w-72 bg-white h-full border-r"
        style="z-index: 90"
      >
        <div class="flex items-center justify-center h-14 border-b ml-12 mt-3">
          <h1 class="flex items-center text-xl font-extrabold">
            TimeManager<span
              class="bg-blue-100 text-blue-800 text-xl font-semibold mr-2 px-2.5 py-0.5 rounded dark:bg-blue-200 dark:text-blue-800 ml-2"
              >PRO</span
            >
          </h1>
        </div>
        <div class="overflow-y-auto overflow-x-hidden flex-grow">
          <ul class="flex flex-col py-4 space-y-1">
            <li class="px-5">
              <div class="flex flex-row items-center h-8">
                <div class="text-sm font-light tracking-wide text-gray-500">
                  Menu
                </div>
              </div>
            </li>
            <li>
              <a
                @click="Dashboard"
                href="#"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 text-gray-600 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span class="inline-flex justify-center items-center ml-4">
                  <svg
                    class="w-5 h-5"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"
                    ></path>
                  </svg>
                </span>
                <span
                  @click="Dashboard"
                  class="ml-2 text-sm tracking-wide truncate"
                  >Dashboard 🚀</span
                >
              </a>
            </li>
            <li v-if="isAdmin">
              <a
                @click="Admin"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 text-gray-600 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span class="inline-flex justify-center items-center ml-4">
                  <svg
                    class="w-5 h-5"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"
                    ></path>
                  </svg>
                </span>
                <span
                  @click="Dashboard"
                  class="ml-2 text-sm tracking-wide truncate"
                >
                  Admin Dashboard 🚀
                </span>
              </a>
            </li>
            <li>
              <a
                @click="Clock"
                href="#"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 text-gray-600 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span class="inline-flex justify-center items-center ml-4">
                  <svg
                    class="w-6 h-6"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71V3.5z"
                    />
                    <path
                      d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0z"
                    />
                  </svg>
                </span>
                <span @click="Clock" class="ml-2 text-sm tracking-wide truncate"
                  >My Clock</span
                >
              </a>
            </li>
            <li>
              <a
                @click="workingTimes"
                style="cursor: pointer"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 text-gray-600 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span class="inline-flex justify-center items-center ml-4">
                  <svg
                    class="w-5 h-5"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z"
                    ></path>
                  </svg>
                </span>
                <span class="ml-2 text-sm tracking-wide truncate"
                  >My Workingtimes</span
                >
              </a>
            </li>
            <li class="px-5">
              <div class="flex flex-row items-center h-8">
                <div class="text-sm font-light tracking-wide text-gray-500">
                  Settings
                </div>
              </div>
            </li>
            <li>
              <a
                @click="Profile"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 text-gray-600 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span class="inline-flex justify-center items-center ml-4">
                  <svg
                    class="w-5 h-5"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"
                    ></path>
                  </svg>
                </span>
                <span class="ml-2 text-sm tracking-wide truncate">Profile</span>
              </a>
            </li>
            <li>
              <a
                @click="Teams"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 text-gray-600 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span class="inline-flex justify-center items-center ml-4">
                  <svg
                    class="w-5 h-5"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"
                    ></path>
                  </svg>
                </span>
                <span class="ml-2 text-sm tracking-wide truncate">Teams</span>
              </a>
            </li>
            <li>
              <a
                @click="Logout"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 text-gray-600 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span class="inline-flex justify-center items-center ml-4">
                  <svg
                    class="w-5 h-5"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"
                    ></path>
                  </svg>
                </span>
                <span class="ml-2 text-sm tracking-wide truncate">Logout</span>
              </a>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>

  <!-- IF NO USER CONNECTED -->
  <!-- SIGN IN-->
  <div class="" v-if="!isUserConnected">
    <div
      class="p-12 bg-base-300 mx-auto rounded-2xl md:w-fit sm:w-full"
      id="SignInDiv"
      v-if="SignInDiv"
    >
      <div class="mb-4">
        <h3 class="font-semibold text-2xl text-white">Sign In</h3>
        <p class="text-gray-500">Please sign in to your account.</p>
      </div>
      <div class="space-y-5">
        <div class="space-y-2">
          <label class="text-sm font-medium text-white tracking-wide"
            >Email</label
          >
          <input
            v-model="email"
            class="w-full text-base px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-400"
            type="email"
            placeholder="Enter your email"
          />
        </div>
        <div class="space-y-2">
          <label class="text-sm font-medium text-white tracking-wide"
            >password</label
          >
          <input
            v-model="password"
            class="w-full text-base px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-400"
            type="password"
            placeholder="Enter your password"
          />
        </div>

        <div>
          <button
            @click="API"
            type="submit"
            class="w-full flex justify-center bg-green-400 hover:bg-green-500 text-gray-100 p-3 rounded-full tracking-wide font-semibold shadow-lg cursor-pointer transition ease-in duration-500"
          >
            <div>SIGN IN</div>

            <div v-if="loading" role="status" class="ml-10">
              <svg
                aria-hidden="true"
                class="w-6 h-6 text-gray-200 animate-spin dark:text-gray-600 fill-blue-600"
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
          </button>
        </div>
      </div>

      <div class="pt-5 text-center text-gray-400 text-xs">
        <span>
          <button
            class="text-green hover:text-green-500"
            @click="CreateAccountButton"
          >
            CREATE NEW ACCOUNT
          </button>
        </span>
      </div>
    </div>

    <!-- IF CLICKED CREATE ACCOUNT -->
    <!-- CREATE ACC-->
    <div
      class="p-12 bg-base-300 mx-auto rounded-2xl md:w-fit sm:w-full"
      id="CreateAccountDiv"
      v-show="showCreateAccount"
    >
      <div class="mb-4">
        <h3 class="font-semibold text-2xl text-white">Get Registred</h3>
        <p class="text-gray-500">Create a new user account</p>
      </div>
      <div class="space-y-5">
        <div class="space-y-2">
          <label class="text-sm font-medium text-white tracking-wide"
            >Username</label
          >
          <input
            v-model="username"
            class="w-full text-base px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-400"
            type=""
            placeholder="Enter your username"
          />
        </div>
        <div class="space-y-2">
          <label class="mb-5 text-sm font-medium text-white tracking-wide">
            Email
          </label>
          <input
            v-model="email"
            class="w-full content-center text-base px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-400"
            type="email"
            placeholder="Enter your email"
          />
        </div>
        <div class="space-y-2">
          <label class="mb-5 text-sm font-medium text-white tracking-wide">
            Password
          </label>
          <input
            v-model="password"
            class="w-full content-center text-base px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-400"
            type="password"
            placeholder="Enter your password"
          />
        </div>
        <div class="flex items-center justify-between"></div>
        <div>
          <button
            @click="CreateUSER"
            type="submit"
            class="w-full flex justify-center bg-green-400 hover:bg-green-500 text-gray-100 p-3 rounded-full tracking-wide font-semibold shadow-lg cursor-pointer transition ease-in duration-500"
          >
            CREATE ACCOUNT
          </button>
        </div>
      </div>

      <div class="pt-5 text-center text-gray-400 text-xs">
        <span>
          <button class="text-green hover:text-green-500" @click="Backtologin">
            ALREADY HAVE AN ACCOUNT ? LOG IN HERE
          </button>
        </span>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      SignInDiv: true,
      showCreateAccount: false,
      username: "",
      email: "",
      isUserConnected: !!localStorage.getItem("userId"),
      loading: false,
    };
  },
  methods: {
    CreateAccountButton() {
      this.SignInDiv = false;
      this.showCreateAccount = !this.showCreateAccount;
    },
    Backtologin() {
      this.SignInDiv = true;
      this.showCreateAccount = false;
    },
    Logout() {
      this.isUserConnected = false;
      localStorage.removeItem("userId");
      localStorage.removeItem("role");
      const $toast = useToast();
      $toast.success("You are logged out!");
      localStorage.removeItem("userEmail");
      localStorage.removeItem("userUsername");
      this.isUserConnected = false;
      VueCookies.remove("token");
      this.$router.replace("/");
    },
    Dashboard() {
      this.$router.push("/dashboard/" + localStorage.getItem("userId"));
    },
    Clock() {
      this.$router.push("/clock/" + localStorage.getItem("userId"));
    },
    Profile() {
      this.$router.push("/Profile/" + localStorage.getItem("userId"));
    },
    workingTimes() {
      this.$router.push("/working-times/" + localStorage.getItem("userId"));
    },
    Admin() {
      this.$router.push("/admin");
    },
    Teams() {
      this.$router.push("/Teams/" + localStorage.getItem("userId"));
    },
    async API() {
      this.loading = true;
      const email = this.email;
      const pass = this.password;

      try {
        const response = await axios.post(
          `http://44.207.191.254:4000/api/login?email=${email}&password=${pass}`,
          {},
          { withCredentials: true }
        );

        if (response.data.user) {
          this.isUserConnected = true;
          console.log("setting local storage");
          localStorage.setItem("role", response.data.user.role);
          localStorage.setItem("userId", response.data.user.id);
          localStorage.setItem("userUsername", response.data.user.username);

          router.push("/dashboard/" + response.data.user.id);
          const $toast = useToast();
          $toast.success("Logged in!");
          this.loading = false;
        }
      } catch (error) {
        console.error("API request failed:", error);
        const $toast = useToast();
        $toast.error("Something went wrong!");
        this.loading = false;
      }
    },
    // Méthode pour créer un utilisateur (POST)
    CreateUSER() {
      const username = this.username;
      const email = this.email;
      const password = this.password;
      axios
        .post(
          `http://44.207.191.254:4000/api/users?email=${email}&username=${username}&password=${password}&role=employee`
        )
        .then((response) => {
          const $toast = useToast();
          $toast.success("Account created! Please login!");
          this.SignInDiv = true;
          this.showCreateAccount = false;
          console.log(response.data);
        })
        .catch((error) => {
          console.error("API request failed: USER FAILED TO BE ADDED", error);
        });
    },
  },
};
</script>

<style scoped></style>
