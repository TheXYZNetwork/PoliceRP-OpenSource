local plyMeta = FindMetaTable("Player")

DarkRP.declareChatCommand{
    command = "job",
    description = "Change your job name",
    delay = 1.5,
    condition = fn.Compose{fn.Not, plyMeta.isArrested}
}