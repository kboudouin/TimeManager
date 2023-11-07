<template>
  <div class="container mx-auto py-4">
    <h1 class="text-3xl font-semibold mb-4">Gestion des équipes</h1>

    <!-- Section "Mes équipes" -->
    <section class="mb-8">
      <h2 class="text-xl font-semibold mb-4">Mes équipes</h2>
      <div class="carousel w-full">
        <div
          v-for="(group, index) in groupedTeams"
          :key="index"
          :id="'slide' + (index + 1)"
          class="carousel-item relative w-full"
        >
          <ul class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            <li
              v-for="team in group"
              :key="team.id"
              class="bg-white p-4 rounded-lg shadow"
            >
              <h3 class="text-lg font-semibold">{{ team.name }}</h3>
              <p class="text-gray-500">{{ team.description }}</p>
              <button
                @click="editTeam(team.id)"
                class="mt-4 bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600"
              >
                Modifier
              </button>
            </li>
          </ul>
          <div
            class="absolute flex justify-between transform -translate-y-1/2 left-5 right-5 top-1/2"
          >
            <a
              :href="
                '#slide' + (index === 0 ? groupedTeams.length - 1 : index - 1)
              "
              class="btn btn-circle"
              >❮</a
            >
            <a
              :href="
                '#slide' + (index === groupedTeams.length - 1 ? 0 : index + 1)
              "
              class="btn btn-circle"
              >❯</a
            >
          </div>
        </div>
      </div>
    </section>

    <!-- Section "Toutes les équipes" -->

    <section class="mb-8">
      <h2 class="text-xl font-semibold mb-4">Toutes les équipes</h2>
      <div class="carousel w-full">
        <div
          v-for="(group, index) in groupedTeams"
          :key="index"
          :id="'slide' + (index + 1)"
          class="carousel-item relative w-full"
        >
          <ul class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            <li
              v-for="team in group"
              :key="team.id"
              class="bg-white p-4 rounded-lg shadow"
            >
              <h3 class="text-lg font-semibold">{{ team.name }}</h3>
              <p class="text-gray-500">{{ team.description }}</p>
              <button
                @click="editTeam(team.id)"
                class="mt-4 bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600"
              >
                Modifier
              </button>
            </li>
          </ul>
          <div
            class="absolute flex justify-between transform -translate-y-1/2 left-5 right-5 top-1/2"
          >
            <a
              :href="
                '#slide' + (index === 0 ? groupedTeams.length - 1 : index - 1)
              "
              class="btn btn-circle"
              >❮</a
            >
            <a
              :href="
                '#slide' + (index === groupedTeams.length - 1 ? 0 : index + 1)
              "
              class="btn btn-circle"
              >❯</a
            >
          </div>
        </div>
      </div>
    </section>

    <!-- Section "Créer une nouvelle équipe" -->
    <section class="mb-8">
      <h2 class="text-xl font-semibold mb-4">Créer une nouvelle équipe</h2>
      <button
  @click="toggleCreateForm"
  class="bg-green-500 text-black py-2 px-4 rounded hover:bg-grey-600"
>CREATE TEAM</button>

      <!-- Formulaire de création d'équipe -->
      <div v-if="BOUTONVISIBILITY" class="bg-white p-4 rounded-lg shadow">
        <form @submit.prevent="addTeam">
          <div class="mb-4">
            <label for="teamName" class="block text-black font-semibold"
              >Leader {{leaderIDselected}}</label
            >
            <select
  v-model="newTeam.members"
  id="teamMembers"
  multiple
  class="w-full rounded border p-2 appearance-none"
>

  <option
    v-for="leader in availableLeaders"
    :key="leader.id"
    :value="leader.id"
    @click="addSelectedLeader(leader.id)"
  >
  ID : {{ member.id }} USERNAME : {{ member.username }} EMAIL : {{ member.email }}
    ID : {{ leader.id }} USERNAME : {{ leader.username }} EMAIL : {{ leader.email }}
  </option>
</select>
          </div>
          <div class="mb-4">
            <label for="teamMembers" class="block text-black font-semibold"
              >Members</label
            >

            <select
  v-model="newTeam.members"
  id="teamMembers"
  multiple
  class="w-full rounded border p-2 appearance-none"
>

  <option
    v-for="member in availableMembers"
    :key="member.id"
    :value="member.id"
    @click="addSelectedMember(member.id)"
  >
    ID : {{ member.id }} USERNAME : {{ member.username }} EMAIL : {{ member.email }}
  </option>
</select>
          </div>
          <!-- Liste des membres sélectionnés -->
          <div class="mb-4">
            <label class="block text-black font-semibold"
              >Membres sélectionnés</label
            >
            <div class="flex flex-wrap">
              <span
                v-for="memberId in newTeam.members"
                :key="memberId"
                class="bg-gray-200 text-gray-600 px-2 py-1 m-1 rounded-lg flex items-center"
              >test
                {{
                  availableMembers.find((member) => member.id === memberId).name
                }}
                <button
                  @click="removeMember(memberId)"
                  class="ml-2 text-red-600 hover:text-red-800"
                >
                  <svg
                    class="h-4 w-4"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M6 18L18 6M6 6l12 12"
                    ></path>
                  </svg>
                </button>
              </span>
            </div>
          </div>
          <div class="mb-4">
            <label class="block text-black font-semibold"
              >Description de l'équipe</label
            >
            <textarea class="w-full rounded border p-2"></textarea>
          </div>
          <button
            type="submit"
            class="bg-blue-500 text-white py-2 px-4 rounded hover-bg-blue-600"
          >
            Créer
          </button>
        </form>
      </div>
    </section>
  </div>
</template>

<script>
import { ref, onMounted } from "vue";
import axios from "axios";
import VueCookies from "vue-cookies";
import { useToast } from "vue-toast-notification";

export default {
  data() {
    return {
      BOUTONVISIBILITY: false,
      leaderIDselected: null,
      nameusername: string,
    };
  },
  methods: {

    test(){
      console.log("test reussi");
    },

    addSelectedMember(memberId) {
    const member = this.availableMembers.find((m) => m.id === memberId);
    if (member) {
      this.selectedMembers.push(member.username);
      nameusername = member.username;
      console.log("le membre selectionner est"+ member.username);
    }
  },

  addSelectedLeader(leader){

    console.log("alors leader : "+leader);
    leaderIDselected = leader;
    console.log("leaderIDselected : "+this.leaderIDselected);

  },

    BOUTON(){
      console.log("avant clique"+ BOUTONVISIBILITY);
      if (this.BOUTONVISIBILITY = true){
        this.BOUTONVISIBILITY == false;
      }else if(this.BOUTONVISIBILITY = false){
        this.BOUTONVISIBILITY == true;
      }
      console.log("apres clique"+ BOUTONVISIBILITY);
    },
  },
  
  setup() {
    const teams = [
      { id: 1, name: "Équipe A", description: "Description de l'équipe A" },
      { id: 2, name: "Équipe B", description: "Description de l'équipe B" },
      { id: 3, name: "Équipe C", description: "Description de l'équipe C" },
      // Ajoutez d'autres équipes ici
    ];

    const creatingTeam = ref(false);
    const newTeam = ref({
      name: "",
      
      description: "",
      members: [],
    });

    const availableMembers = ref([
    ]);
    const groupedTeams = ref([]);
    const selectedMembers = ref([]);

    const availableLeaders=ref([]);

    const addSelectedLeader =(leaderId) => {
      console.log("ajout leader ID : "+ leaderId);
      };

    const addSelectedMember = (memberId) => {
      if (!newTeam.members.includes(memberId)) {
        newTeam.members.push(memberId);
        console.log(memberId);
        console.log(newTeam);
      }
    };

    const removeMember = (memberId) => {
      const index = newTeam.members.indexOf(memberId);
      if (index !== -1) {
        newTeam.members.splice(index, 1);
      }
    };

    const showCreateTeamForm = () => {
      creatingTeam.value = true;
      newTeam.value = { name: "", description: "", members: [] };
    };

    const toggleCreateTeamForm = () => {
      this.showCreateTeamForm = !this.showCreateTeamForm;
    };

    const addTeam = async () => {
      try {
        const response = await axios.post(
          "https://epitechproject.com/api/teams",
          newTeam.value
        );

        if (response.status === 201) {
          useToast().success("Équipe ajoutée avec succès.");
          creatingTeam.value = false;

          // Ajoutez l'équipe nouvellement créée à la liste des équipes
          teams.push({
            leaderId: teams.length + 1,
            leader: newTeam.value.name,
            members: newTeam.value.members,
          });

          // Mise à jour de groupedTeams
          console.log("reussi");
          groupedTeams.value = groupTeams(teams);
        } else {
          useToast().error("Erreur lors de l'ajout de l'équipe.");
        }
      } catch (error) {
        console.error("Erreur lors de l'ajout de l'équipe", error);
        useToast().error("Erreur lors de l'ajout de l'équipe.");
      }
    };

    const API = () => {
      const token = localStorage.getItem("token");
      console.log("Récupération de la liste des membres en cours...");
      axios
        .get("https://epitechproject.com/api/users", {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        })
        .then((response) => {
          console.log("Membres trouvés");
          console.log(response.data);

          if (response.data.users) {
            availableMembers.value = response.data.users;
            availableLeaders.value = response.data.users;
            console.log("availableLeaders:"+ availableLeaders);
          }
        })
        .catch((error) => {
          console.error("Requête API échouée :", error);
        });
    };

    const BOUTONVISIBILITY = ref(false);

    const toggleCreateForm = () => {
      BOUTONVISIBILITY.value = true;
    };

    onMounted(() => {
      API();
    });

    return {
      BOUTONVISIBILITY,
      teams,
      creatingTeam,
      newTeam,
      groupedTeams,
      showCreateTeamForm,
      addTeam,
      availableMembers,
      selectedMembers,
      addSelectedMember,
      toggleCreateForm,
      toggleCreateTeamForm,
      removeMember,
      addSelectedLeader,
    };
  },
};
</script>
